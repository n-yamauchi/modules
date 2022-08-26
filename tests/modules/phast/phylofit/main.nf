#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { PHAST_PHYLOFIT } from '../../../../modules/phast/phylofit/main.nf'

workflow test_phast_phylofit {
    input = [
        [ id:'test' ], // meta map
        file("/flash/LuscombeU/nico/testdata/test.mfa.gz"),
        file("/flash/LuscombeU/nico/testdata/test.tree")
    ]

    PHAST_PHYLOFIT ( input )
}
