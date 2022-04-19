
process MEME_FIMO {
    tag "$meta.id"
    label 'process_medium'

    conda (params.enable_conda ? "bioconda::meme=5.4.1" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/meme:5.4.1--py39pl5321hd8da745_2':
        'quay.io/biocontainers/meme:5.4.1--py27pl5321h2d77908_1' }"

    input:

    tuple val(meta), path(meme), path(fasta)

    output:

    tuple val(meta), path('fimo_out/*.html')     , optional: true, emit: html
    tuple val(meta), path('fimo_out/*.tsv')      , optional: true, emit: tsv
    tuple val(meta), path('fimo_out/*.gff')      , optional: true, emit: gff
    tuple val(meta), path('fimo_out/*cisml.xml') , optional: true, emit: cismlxml
    tuple val(meta), path('fimo_out/*fimo.xml')  , optional: true, emit: fimoxml

    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    def html_out = args.contains('-html') ? "-htmlout ${prefix}_fimo.html" : ''
    def tsv_out = args.contains('-tsv') ? "-tsvout ${prefix}_fimo.tsv" : ''
    def gff_out = args.contains('-gff') ? "-gffout ${prefix}_fimo.gff" : ''
    def cisml_xml_out = args.contains('-cismlxml') ? "-cismlxmlout ${prefix}_cisml.xml" : ''
    def fimo_xml_out = args.contains('-fimoxml') ? "-fimoxmlout ${prefix}_fimo.xml" : ''

    """
    fimo \\
        $args \\
        $tsv_out \\
        $gff_out \\
        $cisml_xml_out \\
        $fimo_xml_out \\
        $html_out \\
        $meme \\
        $fasta 


    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        meme: \$(echo \$(fimo --version 2>&1) | sed 's/^.*fimo: //; s/ .*\$//' ))
    END_VERSIONS
    """
}
