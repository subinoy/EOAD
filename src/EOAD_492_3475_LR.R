
library(GMMAT)


#pheno <- read.table("pca_genomic_IID_pheno.txt", header = TRUE, na.strings = "NA")
pheno <- read.csv("llfs_3475_wgs_pheno_Aug31.csv", row.names=1)

GRM <- as.matrix(read.table("llfs_3475_WGSGRM1.cXX.txt.gz"))

rownames(GRM) <- colnames(GRM) <- pheno$IID





model0 <- glmmkin(fixed = EOAD_492 ~ sex + New_Age_at_Onset + E4  + edu + PCA1 + PCA2 + PCA3, data = pheno, kins = GRM, id = "IID", family = binomial(link = "logit"))
model0$theta

model0$coefficients

model0$cov


glmm.score(model0, infile = "NS_EOAD_492_mem_SNPs", outfile = "NS_EOAD_492_mem_SNPs_Sept14_out.txt")


