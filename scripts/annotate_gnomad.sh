#!/bin/bash
#SBATCH --job-name=gnomad_filter
#SBATCH --time=02:00:00
#SBATCH --partition=medium
#SBATCH --out=gnomad_%a.log
#SBATCH --array=1-20
#SBATCH --cpus-per-task=1

n=${SLURM_ARRAY_TASK_ID}
bcftools query -f'%CHROM\t%POS\n' by_chrom/${n}.vcf.gz > by_chrom/${n}.query
printf '##CHROM\tPOS\tREF\tALT\tAF_joint\n' > by_chrom/${n}.gnomad.anno.txt
bcftools view -R by_chrom/${n}.query ../../../gnomad/gnomad.joint.v4.1.sites.chr${n}.vcf.bgz | \
bcftools query -f'%CHROM\t%POS\t%REF\t%ALT\t%INFO/AF_joint\n' >> by_chrom/${n}.gnomad.anno.txt
echo '##INFO=<ID=AF_joint,Number=1,Type=Float,Description="gnomad v4.1 AF">' > by_chrom/${n}.header.txt
bgzip -c by_chrom/${n}.gnomad.anno.txt > by_chrom/${n}.gnomad.anno.txt.gz
tabix -s 1 -b2 -e 2 by_chrom/${n}.gnomad.anno.txt.gz
bcftools annotate -a by_chrom/${n}.gnomad.anno.txt.gz -h by_chrom/${n}.header.txt -c CHROM,POS,REF,ALT,AF_joint -Ov -o by_chrom/${n}.gnomad.vcf.gz by_chrom/${n}.vcf.gz
#only controls
bcftools view --force-samples -S control_ids.txt -Ou by_chrom/${n}.gnomad.vcf.gz | \
bcftools +fill-tags -Ou -- -t AF,AN,AC | \
bcftools query -f'%CHROM\t%POS\t%AF_joint\t%AF\n' | awk '{ if (sqrt(($3 - $4)^2) > 0.2) print $1 "\t" $2 }' > by_chrom/${n}.bad_af.txt
bcftools view -T ^by_chrom/${n}.bad_af.txt by_chrom/${n}.vcf.gz -Oz -o by_chrom/${n}.af_filt.vcf.gz 

