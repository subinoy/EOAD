proc 2512iLPh2US {} {
    load pedigree solar_ped.1.csv
    pedigree show
    load pheno pheno_solar_US3475.csv

        trait 	New_Age_at_Onset
	covar sex edu APOE2 APOE4 fEOAD_82_solr2 PCA1 PCA2 PCA3
	polygenic -s -p 0.99   
    	mibddir /mnt/vast/hpc/lee_lab/LLFS-Data/IBD_haplotype_wgs_gwas_08.25.2022/mibd_grid_cMH_wholenum_all/
    	chromosome all
    	interval 1
    	multipoint




    	quit
}
