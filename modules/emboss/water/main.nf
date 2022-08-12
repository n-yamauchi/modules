process EMBOSS_WATER {
    tag "$meta.id"
    label 'process_medium'

    conda (params.enable_conda ? "bioconda::emboss=6.6.0" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/emboss:6.6.0--h0b54518_4':
        'quay.io/biocontainers/emboss:6.6.0--h1b6f16a_5' }"

    input:
    tuple val(meta), path(fasta1), path(fasta2)

    output:
    tuple val(meta), path("*.water.txt"), emit: txt
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    water \\
        $args \\
        -auto \\
        -out ${prefix}.water.txt \\
        -asequence $fasta1 \\
        -bsequence $fasta2

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        emboss: \$(echo \$(water --version 2>&1) | sed 's/^.*water //; s/.*\$//' ))
    END_VERSIONS
    """
}
