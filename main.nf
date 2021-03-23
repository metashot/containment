#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { mash_paste; mash_sketch; mash_screen } from './modules/mash'
include { mult_table } from './modules/utils'

workflow {
    
    Channel
        .fromFilePairs(params.reads, size: -1)
        .set { reads_ch }

    db_in = file(params.db, type: 'file', checkIfExists: true)
    
    if (params.db_format == "sketch") {
        mash_paste(db_in)
        db = mash_paste.out.db_msh
    } else {
        mash_sketch(db_in)
        db = mash_sketch.out.db_msh
    }

    mash_screen(db, reads_ch)
    mult_table(mash_screen.out.screens.collect())
}
