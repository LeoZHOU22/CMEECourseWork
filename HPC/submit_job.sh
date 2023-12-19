#!/bin/bash

#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb

# Load the Anaconda module
module load anaconda3/personal
echo "R is about to run"

# Run the R script
R --vanilla < $HOME/LZ723/lz723_HPC_2023_neutral_cluster.R

# Move output files to the specified directory
mv simulation_result_* $HOME/LZ723

echo "R has finished running"
