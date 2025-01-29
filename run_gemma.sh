#!/bin/bash
#SBATCH --job-name=gemma
#SBATCH --output=gemma_grm.log
#SBATCH --mem=256GB
#SBATCH --cpus-per-task=32
#SBATCH --time=12:00:00
#SBATCH --partition=medium

./gemma -bfile topmed_imputation/merged_maf_01 -gk 1 -outdir gemma_runs/ -o merged_maf_01_grm

