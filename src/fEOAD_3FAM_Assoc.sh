#!/bin/bash
#source /mnt/mfs/cluster/bin/HgrcPathSetup.sh

module load Plink/1.9.10
#plink --bfile /mnt/vast/hpc/lee_lab/LLFS-Data/LLFS-WGS-Freez5.01.14.2022/VCF/Diallelic_SNPs/PLINK-Format/PooledCH1-22/LLFSFz5CH01-22 --keep EOAD_53_ind.txt --make-bed --out EOAD_53_WGS


#plink --bfile /mnt/vast/hpc/lee_lab/LLFS-Data/LLFS-WGS-Freez5.01.14.2022/VCF/Diallelic_SNPs/PLINK-Format/PooledCH1-22/LLFSFz5CH01-22 --keep EOAD_53_Fam_mem_ID.txt --make-bed --out EOAD_53_527mem_WGS

#plink --bfile /mnt/vast/hpc/lee_lab/LLFS-Data/LLFS-WGS-Freez5.01.14.2022/VCF/Diallelic_SNPs/PLINK-Format/PooledCH1-22/LLFSFz5CH01-22 --keep ind_ID_53_fam_members.txt --make-bed --out EOAD_53_WGS_527members

#plink --bfile EOAD_53_WGS_527members --extract nonsyn_snps.txt --make-bed --out  EOAD_53_Fam_527_392k_SNPs

#plink --bfile EOAD_53_Fam_527_392k_SNPs --maf 0.000001  --make-bed --out EOAD_53_Fam_527_maf_filt_SNPs


#plink --bfile llfs_WGS_3475 --extract EOAD_53_Fam_100k_snp_list.txt --make-bed --out NS_100K_SNPs_3475_llfs

# sEOAD processing

# plink --bfile /mnt/vast/hpc/lee_lab/LLFS-Data/LLFS-WGS-Freez5.01.14.2022/VCF/Diallelic_SNPs/PLINK-Format/PooledCH1-22/LLFSFz5CH01-22 --keep sEOAD_410mem_ID.txt --make-bed --out sEOAD_42_Fam_410_mem

# plink --bfile sEOAD_42_Fam_410_mem --extract nonsyn_392K.txt --make-bed --out  sEOAD_42_Fam_410_mem_392k_SNPs

# plink --bfile sEOAD_42_Fam_410_mem_392k_SNPs --maf 0.000001  --make-bed --out sEOAD_42_Fam_410_filt_SNPs
# #94852 SNPs filtered

# cat sEOAD_42_Fam_410_filt_SNPs.bim|cut -f 2 >sEOAD_42_Fam_snp_list.txt


# plink --bfile sEOAD_42_Fam_410_mem_392k_SNPs --extract sEOAD_42_Fam_snp_list.txt --make-bed --out NS_sEOAD_410_mem_SNPs

# Edit sEOAD_445_3475_LR.R Done
# Edit llfs_3475_wgs_pheno_March22.csv Done

# Edit 
 # sEOAD_445_3475_LR Done

# Then RUN the Logistic Regression test on filtered SNPs on the respective data group like fEOAD, sEOAD or LOAD

# BREAK **************
 # Edit NS_LOAD_2948_mem_SNPs.fam file and replace sex on 5th col and AD status on 6th column
 ## ****** AD status replace 1 -> 2 first and then 0 -> 1 and then save it as .txt in MAC computer
 ## Rename the extension bac to .fam in cluster or other machine.


#plink --bfile NS_LOAD_2948_mem_SNPs --assoc --ci .95 --out Association_NS_LOAD_2948_mem_SNPs

plink --bfile fEOAD_82_filt_WGS --freq --nonfounders --out Freq_MAF_3_fEOAD_82_mem_NS_SNPs
plink --bfile fEOAD_82_filt_WGS --assoc --ci .95 --out Assoc_NS_fEOAD_82_mem_SNPs
#

plink --bfile fEOAD_82_mem_7K_SNPs --freq --nonfounders --out Freq_MAF_3_fEOAD_82_mem_NS_7KSNPs

plink --bfile fEOAD_82_mem_7K_SNPs --assoc --ci .95 --out Assoc_NS_fEOAD_82_mem_SNPs