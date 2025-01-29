### Athlete GWAS with GEMMA

## TOPMed imputation

### **1. Quality Control Filters (Applied to Controls Only)**
- Hardy-Weinberg Equilibrium (HWE): Variants with HWE p-value < 1e-6 in controls were removed.
- **Minor Allele Frequency (MAF):** Variants with MAF < 1% in controls were removed.
- **Genotyping Missingness:** Variants with genotyping missingness >1% in controls were removed.
- **Relatedness Filtering:** Second-degree related individuals in athletes and controls were removed using KING.

### **2. Liftover to hg38**
- Converted variant coordinates from hg19 to hg38 using `bcftools liftover`.

### **3. Population Frequency Filtering**
- Annotated allele frequency (AF) using gnomAD v4.1.
- Variants with an AF difference >0.2 between the dataset and gnomAD were removed.

### **4. Imputation and Phasing**
- Uploaded filtered variants to the TopMed Imputation Server for imputation and phasing.
- Post-imputation filtering:
  - Retained variants with INFO > 0.3.
  - Applied MAF > 1% filter in controls again.

## Association Analysis with GEMMA
- See gemma bash scripts for example
- Binary phenotypes where:
  - `1 = elite athlete (case)`
  - `0 = control`
- Sex encoded as:
  - `0 = Unkown`
  - `1 = Male`
  - `2 = Female`

