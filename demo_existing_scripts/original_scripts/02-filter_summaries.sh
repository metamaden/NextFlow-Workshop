#!/bin/bash

#SBATCH -p shared
#SBATCH -c 1
#SBATCH --mem=3G
#SBATCH --job-name=02-filter_summaries
#SBATCH -o 02-filter_summaries_%a.log
#SBATCH -e 02-filter_summaries_%a.log
#SBATCH --array=1-2%2

sample_ids=('sample1' 'sample2')

this_sample_id=${sample_ids[$((${SLURM_ARRAY_TASK_ID} - 1))]}
summary_file=out/${this_sample_id}_fastqc/summary.txt

module load conda_R/4.3
Rscript filter_summaries.R $summary_file
