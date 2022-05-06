
process MEME_MAST {
    tag "$meta.id"
    label 'process_medium'

    conda (params.enable_conda ? "bioconda::meme=5.4.1" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/meme:5.4.1--py39pl5321hd8da745_2':
        'quay.io/biocontainers/meme:5.4.1--py27pl5321h2d77908_1' }"

    input:

    tuple val(meta), path(meme), path(fasta)

    output:

    tuple val(meta), path('mast_out/*.html')     , optional: true, emit: html
    tuple val(meta), path('mast_out/*.txt')      , optional: true, emit: txt
    tuple val(meta), path('mast_out/*.xml')      , optional: true, emit: xml

    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    // def html_out = args.contains('-html') ? "-htmlout ${prefix}_mast.html" : ''
    // def txt_out = args.contains('-txt') ? "-txtout ${prefix}_mast.txt" : ''
    // def xml_out = args.contains('-xml') ? "-xmlout ${prefix}_mast.xml" : ''

    """
    mast \\
        $args \\
        $meme \\
        $fasta 

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        meme: \$(echo \$(mast --version 2>&1) | sed 's/^.*mast //; s/ .*\$//' ))
    END_VERSIONS
    """
}
