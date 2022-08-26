#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { PHAST_PHYLOP } from '../../../../modules/phast/phylop/main.nf'

workflow test_phast_phylop {

    // input = [
    //     [ id:'test' ], // meta map
    //     file("/flash/LuscombeU/nico/LuscombeU_OikFunction/work/0a/7ba8fb1addfd57d41d2b9b3130b708/N19.HOG0005198.mfa.gz"),
    //     file("/flash/LuscombeU/nico/LuscombeU_OikFunction/work/0a/7ba8fb1addfd57d41d2b9b3130b708/N19.HOG0005198.mod")
    // ]
    // input = [
    //     [ id:'test' ], // meta map
    //     file("/flash/LuscombeU/nico/testdata/test.mfa.gz"),
    //     file("/flash/LuscombeU/nico/testdata/test.mod")
    // ]
    // input = [
    //     [ id:'test' ], // meta map
    //     file("/flash/LuscombeU/Naohiro/test-datasets_old/data/test1.mfa.gz"),
    //     file("/flash/LuscombeU/Naohiro/test-datasets_old/data/test1.mod")
    // ]

    input = [
        [ id:'test' ], // meta map
        file("/flash/LuscombeU/Naohiro/LuscombeU_OikFunction/work/f0/e1be8d23259508bc920dcdd420fef2/N19.HOG0002471.mfa.gz"),
        file("/flash/LuscombeU/Naohiro/LuscombeU_OikFunction/work/f0/e1be8d23259508bc920dcdd420fef2/N19.HOG0002471.mod")
    ]

    PHAST_PHYLOP ( input )
}
