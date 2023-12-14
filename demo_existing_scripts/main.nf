process FastQC {
    publishDir "${params.output}/fastQC", pattern: "${sample_id}_fastqc"

    input:
        path fastqc_untrimmed_input

    output:
        path "${sample_id}_fastqc"
        file "${sample_id}_summary.txt", emit: fastqc_summary

    shell:
        // Determine sample ID from filename
        sample_id = fastqc_untrimmed_input.tokenize('.')[0]
        '''
        fastqc --extract !{fastqc_untrimmed_input}
        cp !{sample_id}_fastqc/summary.txt !{sample_id}_summary.txt
        '''
}

workflow {
    fastq_files = Channel
        .fromPath("${workflow.projectDir}/demo_existing_scripts/data/sample{1,2}.fastq.gz")
}
