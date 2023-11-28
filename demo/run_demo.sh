#   Request an interactive session on a compute node
srun --pty --mem=10G bash

#   At JHPCE, both Nextflow and Singularity are available as modules. We only
#   need Singularity because this is the most convenenient option
#   'nextflow-io/rnaseq-nf' supports for managing software dependencies (FastQC,
#   Salmon, etc)
module load nextflow/23.10.0
module load singularity/3.11.4

#   Run the 'nextflow-io/rnaseq-nf' pipeline
#
#   '-profile slurm': uses the 'slurm' configuration profile, which was created
#       by the 'rnaseq-nf' authors and happens to submit each process as a SLURM
#       job, with software executed inside singularity containers
#   '-w $MYSCRATCH/work': non-mandatory option accepted by any Nextflow
#       pipeline, specifying Nextflow temporary files to be created under
#       $MYSCRATCH/work, which at JHPCE is a higher-speed disk intended for
#       temporary files
nextflow run \
    -profile slurm \
    -w $MYSCRATCH/work \
    nextflow-io/rnaseq-nf

#   Provide info about the pipeline, including to the GitHub repository and
#   where its files live locally
nextflow info nextflow-io/rnaseq-nf

#   Modify one process of the pipeline, then resume (same command as before,
#   with "-resume" added)
nextflow run \
    -profile slurm \
    -w $MYSCRATCH/work \
    -resume \
    nextflow-io/rnaseq-nf
