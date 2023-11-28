// Taken from https://training.nextflow.io/basic_training/rnaseq_pipeline/#create-a-transcriptome-index-file,
// with additional commentary and small edits

// The below front matter contains shebang, DSL declaration, and docstrings

#!/usr/bin/env nextflow
nextflow.enable.dsl=2

/*
 * define the INDEX process that creates a binary index
 * given the transcriptome file
 */
process INDEX {
    // The reference transcriptome file is passed as input
    input:
    path transcriptome

    // The Salmon index file is passed as output
    output:
    path 'salmon_index'

    // The script component executes the 'salmon index' command from a Linux
    // shell
    script:
    """
    salmon index --threads $task.cpus -t $transcriptome -i salmon_index
    """
}

// Workflow parses INDEX process, storing output as "index_ch"
workflow {
    index_ch = INDEX(params.transcriptome_file)
}

// To invoke the workflow, call "nextflow run workflow.nf"
