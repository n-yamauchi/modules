#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { EMBOSS_NEEDLE } from '../../../../modules/emboss/needle/main.nf'

workflow test_emboss_needle {

    // input = [
    //     [ id:'test'], // meta map
    //     file("/bucket/LuscombeU/common/Nextflow/LuscombeU_OikFunction/testdata/nao_temp/test_Oki.fasta", checkIfExists: true),
    //     file("/bucket/LuscombeU/common/Nextflow/LuscombeU_OikFunction/testdata/nao_temp/test_Osa.fasta", checkIfExists: true)
    // ]

    fasta_file = file('/bucket/LuscombeU/common/Nextflow/LuscombeU_OikFunction/testdata/preprocessing/OKI2018.I69/N19.HOG0000000.fasta')
    original_file_name = fasta_file.getBaseName()
    fasta_ = fasta_file.copyTo("$original_file_name _.fasta")

    input = [
        [ id:'test'], // meta map
        fasta_file,
        fasta_
    ]

    // input = [
    //     [ id:'test'], // meta map
    //     file("/bucket/LuscombeU/common/Nextflow/LuscombeU_OikFunction/testdata/preprocessing/OKI2018.I69/N19.HOG0000000.fasta", checkIfExists: true),
    //     file("/bucket/LuscombeU/common/Nextflow/LuscombeU_OikFunction/testdata/preprocessing/OKI2018.I69/N19.HOG0000000.fasta", checkIfExists: true)
    // ]

    EMBOSS_NEEDLE ( input )
}
