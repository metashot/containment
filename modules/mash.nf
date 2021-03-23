nextflow.enable.dsl=2


process mash_paste {  
    input:
    path(db_msh)

    output:
    path "db.msh", emit: db_msh

    script:
    """
    mash paste \
        db \
        ${db_msh}
    """
}


process mash_sketch {
    publishDir "${params.outdir}/mash_sketch" , mode: 'copy'
    
    input:
    path(db)

    output:
    path "db.msh", emit: db_msh

    script:
    param_amino_acid = params.amino_acid ? "-a" : ''
    param_individual = params.individual ? "-i" : ''
    """
    mash sketch \
        ${db} \
        -p ${task.cpus} \
        -s ${params.sketch_size} \
        ${param_amino_acid} \
        ${param_individual} \
        -o db.msh
    """
}


process mash_screen {
    publishDir "${params.outdir}/mash_screen" , mode: 'copy'
    
    input:
    tuple val(id), path(reads)

    output:
    path (db_msh)
    path (reads)

    script:
    param_winner_takes_all = params.winner_takes_all ? "-w" : ''
    """
    mash screen \
        -i ${params.min_identity} \
        -v ${params.max_pval} \
        ${param_winner_takes_all} \
        -p ${task.cpus} \
        ${db_msh} \
        ${reads} \
        > ${id}.screen.tsv
    """
}
