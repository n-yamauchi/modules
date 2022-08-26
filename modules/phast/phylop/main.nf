process PHAST_PHYLOP {
    tag "$meta.id"
    label 'process_low'

    conda (params.enable_conda ? "bioconda::phast=1.5" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/phast:1.5--hec16e2b_4':
        'quay.io/biocontainers/phast:1.5--h779adbc_3' }"

    input:
    tuple val(meta), path(fasta), path(mod)

    output:
    tuple val(meta), path("*.wig"), emit: wig
    path "versions.yml"           , emit: versions

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

    phyloP \\
        $args \\
        --wig-scores \\
        $mod \\
        $fasta_name \\
        > ${prefix}.wig

    sed -i '1i$meta.id ,phylop' ${prefix}.wig

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        phast: \$(phast | head -n 1 | sed 's/.*v//' 2>&1)
    END_VERSIONS
    """
}
