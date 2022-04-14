#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { MEME_FIMO } from '../../../../modules/meme/fimo/main.nf'

workflow test_meme_fimo {
    
    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
    ]

    MEME_FIMO ( input )
}
