process FastQC {
    publishDir "${params.output}/fastQC", pattern: "${sample_id}_fastqc"

    input:
        path fastqc_untrimmed_input

    output:
        path "${sample_id}_fastqc"
        path "${sample_id}_summary.txt", emit: full_summary

    shell:
        // Determine sample ID from filename
        sample_id = fastqc_untrimmed_input.tokenize('.')[0]
        '''
        fastqc --extract !{fastqc_untrimmed_input}
        cp !{sample_id}_fastqc/summary.txt !{sample_id}_summary.txt
        '''
}

process FilterSummaries {
    input:
        path full_summary

    output:
        path "${sample_id}_filtered_summary.csv", emit: filtered_summary

    shell:
        // Determine sample ID from filename
        sample_id = full_summary.tokenize('_')[0]
        '''
        Rscript filter_summaries.R
        '''
}

workflow {
    fastq_files = Channel
        .fromPath("${workflow.projectDir}/demo_existing_scripts/data/sample{1,2}.fastq.gz")
}
