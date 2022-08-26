#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { BLAST_MAKEBLASTDB } from '../../../../modules/blast/makeblastdb/main.nf'

workflow test_blast_makeblastdb {
    input =  [
        file("/bucket/LuscombeU/common/Nextflow/LuscombeU_OikFunction/testdata/preprocessing/OKI2018.I69/N19.HOG0000000.fasta"),
        file("/bucket/LuscombeU/common/Nextflow/LuscombeU_OikFunction/testdata/preprocessing/OKI2018.I69/N19.HOG0000002.fasta")
     ]

    BLAST_MAKEBLASTDB ( input.flatten() )
}
