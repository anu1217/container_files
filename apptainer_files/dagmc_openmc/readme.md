# How to Use
This def file is intended to be built on UW Madison's HPC cluster, creating an image that can be used to run DAGMC enabled OpenMC. It uses a base image provided on the cluster. It includes HDF5, EMBREE, MOAB, Double Down, DAGMC, and OpenMC.

To build the image, run

`sbatch build_image.sh`

This will build the image using `dagmc_openmc.def` and place the finished image `dagmc_openmc.sif` in this directory. That image can then be used to run future jobs. See the top level readme for how to run a job with an Apptainer image.
