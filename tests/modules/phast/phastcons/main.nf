#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { PHAST_PHASTCONS } from '../../../../modules/phast/phastcons/main.nf'

workflow test_phast_phastcons {

    // input = [
    //     [ id:'test', single_end:false ], // meta map
    //     file("/flash/LuscombeU/nico/LuscombeU_OikFunction/work/0a/7ba8fb1addfd57d41d2b9b3130b708/N19.HOG0005198.mfa.gz"),
    //     file("/flash/LuscombeU/nico/LuscombeU_OikFunction/work/0a/7ba8fb1addfd57d41d2b9b3130b708/N19.HOG0005198.mod")
    // ]

    input = [
        [ id:'test' ], // meta map
        file("/flash/LuscombeU/Naohiro/LuscombeU_OikFunction/work/f0/e1be8d23259508bc920dcdd420fef2/N19.HOG0002471.mfa.gz"),
        file("/flash/LuscombeU/Naohiro/LuscombeU_OikFunction/work/f0/e1be8d23259508bc920dcdd420fef2/N19.HOG0002471.mod")
    ]

    PHAST_PHASTCONS ( input )
}
