#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { mash_paste; mash_sketch; mash_screen } from './modules/mash'

workflow {
    
    Channel
        .fromFilePairs(params.reads, size: -1)
        .set { reads_ch }

    db_in = file(params.db, type: 'file', checkIfExists: true)
    
    if (db_format == "sketch") {
        db = mash_paste(db_in).out.db_msh
    } else {
        db = mash_sketch(db_in).out.db_msh
    }

    mash_screen(db, reads_ch)
}

