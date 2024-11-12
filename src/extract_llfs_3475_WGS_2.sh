#!/bin/bash
source /mnt/mfs/cluster/bin/HgrcPathSetup.sh

# LLFS 3475 processing

plink --bfile LLFS-Data/LLFS-WGS-Freez5.01.14.2022/VCF/Diallelic_SNPs/PLINK-Format/PooledCH1-22/LLFSFz5CH01-22 --keep llfs_3475_mem_ID.txt --make-bed --out LLFS_3475_members_WGS

plink --bfile LLFS_3475_members_WGS --extract nonsyn_snps.txt --make-bed --out  LOAD_2948_mem_392k_SNPs

plink --bfile LLFS_3475_members_WGS --maf 0.000001  --make-bed --out LLFS_3475_filt_WGS
#94852 SNPs filtered

#cat LOAD_2948_mem_maf_filt_SNPs.bim|cut -f 2 >LOAD_2948_mem_snp_list.txt


#plink --bfile LOAD_2948_mem_392k_SNPs --extract LOAD_2948_mem_snp_list.txt --make-bed --out NS_LOAD_2948_mem_SNPs

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
