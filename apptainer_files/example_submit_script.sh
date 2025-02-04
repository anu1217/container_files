#!/bin/bash
#SBATCH --partition=shared
#SBATCH --time=0-24:00:00            
#SBATCH --nodes=10               
#SBATCH --ntasks-per-node=32   
#SBATCH --mem=30000
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

# load required modules here
module load openmpi
# image_path is the path to the Apptainer .sif file you wish to use
export image_path=/path/to/apptainer/image

# mounts the `bind_path` location on the system into the image 
# input files can be stored here, and output files are written here, unless
# otherwise specified.
bind_path=/path/to/bind

# Launches the command MY_COMMAND in parallel with SLURM_NNODES MPI processes
# inside the above apptainer image while mounting the bind_path into the image
# Note that MY_COMMAND may need a flag for thread parallelization to take advantage of the 
# number of tasks per node specified
srun --mpi=pmix -n ${SLURM_NNODES} apptainer exec --bind ${bind_path}:${bind_path} ${image_path} MY_COMMAND

# alternatively, you can replace MY_COMMAND with a bash script (e.g. my_commands.sh) if you need to run multiple commands in sequence
