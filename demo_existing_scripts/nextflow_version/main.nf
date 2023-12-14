process FastQC {
    publishDir "${params.output}/fastQC", pattern: "${sample_id}_fastqc"

    input:
        path fastqc_untrimmed_input

    output:
        path "${sample_id}_fastqc"
        path "${sample_id}_summary.txt", emit: full_summary

    shell:
        // Determine sample ID from filename
        sample_id = file(fastqc_untrimmed_input).name.toString().tokenize('.')[0]
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
        sample_id = file(full_summary).name.toString().tokenize('_')[0]
        '''
        filter_summaries.R
        '''
}

process GatherSummaries {
    publishDir "${params.output}"

    input:
        path filtered_summaries

    output:
        path "combined_summary.csv"
        path "gather_summaries.log"

    shell:
        '''
        gather_summaries.py
        cp .command.log gather_summaries.log
        '''
}

workflow {
    params.output = "${workflow.projectDir}/out"

    fastq_files = Channel
        .fromPath("${workflow.projectDir}/data/sample{1,2}.fastq.gz")
    FastQC(fastq_files)
    FilterSummaries(FastQC.out.full_summary)
    GatherSummaries(FilterSummaries.out.filtered_summary.collect())
}
