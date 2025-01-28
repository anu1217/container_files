#!/bin/bash
#SBATCH --partition=pre
#SBATCH --time=0-04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem-per-cpu=4000
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

# this is correct for UW HPC, it may vary on different clusters
export JOB_TMP_PATH=/local/$USER/${SLURM_JOB_ID}
export TMPDIR=$JOB_TMP_PATH/tmp
export APPTAINER_TMPDIR=$JOB_TMP_PATH/apptainer
mkdir -p $TMPDIR
mkdir -p $APPTAINER_TMPDIR

container_name=dagmc_openmc

apptainer build \
        --bind $TMPDIR:/tmp \
        ${container_name}.sif ${container_name}.def

rm -rf $JOB_TMP_PATH
