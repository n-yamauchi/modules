
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

    tuple val(meta), path("*/*.html")     , emit: html
    tuple val(meta), path("*/*.tsv")      , emit: tsv
    tuple val(meta), path("*/*.gff")      , emit: gff
    tuple val(meta), path("*/*cisml.xml") , emit: cismlxml
    tuple val(meta), path("*/*fimo.xml")  , emit: fimoxml

    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    fimo \\
        $args \\
        --oc ${prefix} \\
        $meme \\
        $fasta 


    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        meme: \$(echo \$(fimo --version 2>&1) | sed 's/^.*fimo: //; s/ .*\$//' ))
    END_VERSIONS
    """
}
