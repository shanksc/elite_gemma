### Athlete GWAS with GEMMA

## TOPMed imputation

### **1. Quality Control Filters (Applied to Controls Only)**
- Hardy-Weinberg Equilibrium (HWE): Variants with HWE p-value < 1e-6 in controls were removed.
- Genotyping Missingness: Variants with genotyping missingness >1% in controls were removed.

### **2. Liftover to hg38**
- Converted variant coordinates from hg19 to hg38 using `bcftools liftover`.

### **3. Population Frequency Filtering**
- Annotated allele frequency (AF) using gnomAD v4.1.
- Variants with an AF difference >0.2 between the dataset and gnomAD were removed.

### **4. Imputation and Phasing**
- Uploaded filtered variants to the TopMed Imputation Server for imputation and phasing.
- Post-imputation filtering:
  - Retained variants with INFO > 0.3.
  - Applied MAF > 1% filter in controls

## Association Analysis with GEMMA
- See gemma bash scripts for example
- Binary phenotypes where:
  - `1 = elite athlete (case)`
  - `0 = control`
- Sex is one hot encoded

