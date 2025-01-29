#!/bin/bash
#SBATCH --job-name=gemma
#SBATCH --output=gemma_lmm.log
#SBATCH --mem=256GB
#SBATCH --cpus-per-task=32
#SBATCH --time=12:00:00
#SBATCH --partition=medium

./gemma -bfile topmed_imputation/merged_maf_01 -k gemma_runs/merged_maf_01_grm.cXX.txt -lmm -outdir gemma_runs -o merged_maf_01_lmm_sex_covar -c gwas_prep/sex_covar.tsv

