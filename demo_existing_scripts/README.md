This directory contains code used as part of the demo showing how to convert an existing workflow of shell scripts (shown under `original_scripts`) into a Nextflow pipeline (shown under `nextflow_version`). In particular, the example shown in `original_scripts` contains shell scripts to be submitted as SLURM jobs, and composing a purely linear/ sequential workflow.

The workflow contains 3 steps:

- Step 1: **Run FastQC**. Under `original_scripts`, 2 FastQ files are run one sample at a time through `FastQC` [using a SLURM array job](https://github.com/metamaden/NextFlow-Workshop/blob/bf67ad15de8025b65683b949c759b4bfa641dce1/demo_existing_scripts/original_scripts/01-FastQC.sh#L9-L13). Similar parallelism is achieved in the `nextflow_version` [here](https://github.com/metamaden/NextFlow-Workshop/blob/bf67ad15de8025b65683b949c759b4bfa641dce1/demo_existing_scripts/nextflow_version/main.nf#L55-L57) by adding the FASTQ inputs to a channel, which becomes two instances of the [`FastQC` process](https://github.com/metamaden/NextFlow-Workshop/blob/bf67ad15de8025b65683b949c759b4bfa641dce1/demo_existing_scripts/nextflow_version/main.nf#L1-L18).
- Step 2: **Filter summaries**. Similar to step 1, 2 samples in total are run, one at a time, through a step that determines failed metrics from FastQC, and outputs a CSV for just the failed metrics.
- Step 3: **Gather summaries**. The filtered FastQC summaries for both samples are gathered and aggregated into a single CSV. Under `original_scripts`, this can be represented as an [ordinary shell script](https://github.com/metamaden/NextFlow-Workshop/blob/main/demo_existing_scripts/original_scripts/03-gather_summaries.sh) (not an array job). Under `nextflow_version`, this gathering of several inputs into a single process execution is achieved with the `.collect()` operator [here](https://github.com/metamaden/NextFlow-Workshop/blob/bf67ad15de8025b65683b949c759b4bfa641dce1/demo_existing_scripts/nextflow_version/main.nf#L59)

Note that programming languages and software can be easily mixed with Nextflow. In [the configuration](https://github.com/metamaden/NextFlow-Workshop/blob/bf67ad15de8025b65683b949c759b4bfa641dce1/demo_existing_scripts/nextflow_version/conf/jhpce.config#L8-L16), we can make use of the modules available at JHPCE to ensure the correct software is available to each process. Using this configuration at run time is as simple as adding `-profile jhpce` to the `nextflow run main.nf` command, since we defined the `jhpce` configuration profile [here](https://github.com/metamaden/NextFlow-Workshop/blob/main/demo_existing_scripts/nextflow_version/nextflow.config).