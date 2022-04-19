#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { MEME_MAST } from '../../../../modules/meme/mast/main.nf'

workflow test_meme_mast {
    
    input = [
        [ id:'test' ], // meta map
        file(params.test_data['bacteroides_fragilis']['motif']['motif_meme'], checkIfExists: true),
        file(params.test_data['sarscov2']['genome']['genome_fasta'], checkIfExists: true)
    ]

    MEME_MAST ( input )
}
