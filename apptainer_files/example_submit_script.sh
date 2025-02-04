#!/bin/bash
#SBATCH --partition=pre       # default "shared", if not specified
#SBATCH --time=0-24:00:00       # run time in days-hh:mm:ss
#SBATCH --nodes=10               # require 1 nodes
#SBATCH --ntasks-per-node=32   # cpus per node (by default, "ntasks"="cpus")
#SBATCH --mem=30000
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

module load openmpi
# image_path is the path to the Apptainer .sif file you wish to use
export image_path=/path/to/apptainer/image

# mounts the `bind_path` location on the system into the image 
# input files can be stored here, and output files are written here, unless
# otherwise specified.
bind_path=/path/to/bind

# This tells slurm to use the apptainer image specified above, along with the
# the bind path to execute the contents of my_executable.sh. You can also
# just type bash commands rather than keeping them in a script, e.g.
# replace my_executable.sh with openmc model.xml
srun --mpi=pmix -n $SLURM_NNODES apptainer exec --bind ${bind_path}:${bind_path} ${image_path} my_executable.sh
