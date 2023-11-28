// The version of https://github.com/nextflow-io/rnaseq-nf/blob/master/modules/multiqc/main.nf
// after modification during the demo

params.outdir = 'results'

process MULTIQC {
    conda 'multiqc=1.17'
    publishDir params.outdir, mode:'copy'

    input:
    path('*') 
    path(config) 

    output:
    path('multiqc_report.html')
    // Add our log as a file that gets outputted
    path('multiqc_log.txt')

    script:
    """
    cp $config/* .
    echo "custom_logo: \$PWD/logo.png" >> multiqc_config.yaml
    multiqc .

    # Process output (i.e. STDOUT and STDERR) gets piped by Nextflow into a
    # temporary file called '.command.log'. We want to give this a better name
    # and keep it as a permanent output
    cp .command.log multiqc_log.txt
    """
}
