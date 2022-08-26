process PHAST_PHYLOFIT {
    tag "$meta.id"
    label 'process_low'

    conda (params.enable_conda ? "bioconda::phast=1.5" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/phast:1.5--hec16e2b_4':
        'quay.io/biocontainers/phast:1.5--h779adbc_3' }"

    input:
    tuple val(meta), path(fasta), path(tree)

    output:
    tuple val(meta), path("*.mod"), emit: mod
    path "versions.yml"                  , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    def is_compressed = fasta.getName().endsWith(".gz") ? true : false
    def fasta_name = fasta.getName().replace(".gz", "")

    """
    if [ "$is_compressed" == "true" ]; then
        gzip -c -d $fasta > $fasta_name
    fi

    phyloFit \\
        $args \\
        --tree $tree \\
        --out-root ${prefix} \\
        $fasta_name

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        phast: \$(phast | head -n 1 | sed 's/.*v//' 2>&1)
    END_VERSIONS
    """
}
