#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { MEME_FIMO } from '../../../../modules/meme/fimo/main.nf'

workflow test_meme_fimo {
    
    input = [
        [ id:'test1' ], // meta map
        file(params.test_data['bacteroides_fragilis']['motif']['motif_meme'], checkIfExists: true),
        file(params.test_data['sarscov2']['genome']['genome_fasta'], checkIfExists: true)
    ]

    MEME_FIMO ( input )
}
