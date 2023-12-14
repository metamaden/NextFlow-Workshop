#!/bin/bash

#SBATCH -p shared
#SBATCH -c 1
#SBATCH --mem=3G
#SBATCH --job-name=01-FastQC
#SBATCH -o 01-FastQC_%a.log
#SBATCH -e 01-FastQC_%a.log
#SBATCH --array=1-2%2

sample_ids=('sample1' 'sample2')

this_sample_id=${sample_ids[$((${SLURM_ARRAY_TASK_ID} - 1))]}
fastq_file=../nextflow_version/data/${this_sample_id}.fastq.gz

module load fastqc/0.12.1
mkdir -p out
fastqc --extract -o out $fastq_file
