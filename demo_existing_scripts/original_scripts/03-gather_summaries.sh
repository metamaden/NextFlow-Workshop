#!/bin/bash

#SBATCH -p shared
#SBATCH -c 1
#SBATCH --mem=3G
#SBATCH --job-name=03-gather_summaries
#SBATCH -o 03-gather_summaries.log
#SBATCH -e 03-gather_summaries.log

module load python/3.9.14
python3 gather_summaries.py
