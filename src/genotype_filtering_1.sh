#!/bin/bash
source /mnt/mfs/cluster/bin/HgrcPathSetup.sh

plink --bfile /mnt/vast/hpc/lee_lab/LLFS-Data/LLFS-WGS-Freez5.01.14.2022/VCF/Diallelic_SNPs/PLINK-Format/PooledCH1-22/LLFSFz5CH01-22 --keep 3Fams117.list --make-bed --out LLFSF3FAD65

plink --bfile LLFSF3AD65 --geno 0.01 --maf 0.05 --nonfounders --make-bed --out EOAD82FM_geno99_MAF_05_qc
