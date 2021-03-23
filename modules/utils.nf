nextflow.enable.dsl=2

process mult_table {      
    publishDir "${params.outdir}" , mode: 'copy'

    input:
    path(screens)
       
    output:
    path 'mult_table.tsv'

    script:
    """
    mkdir screen
    mv $screens screen
    
    mult_table.py \
        screen \
        mult_table.tsv
    """
}
