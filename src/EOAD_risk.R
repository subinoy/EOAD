library(dplyr)
`%nin%` = Negate(`%in%`)

LR_results_stat <- function(LR_out, out_df) {
  require(dplyr)
  #res_file <- paste0(LR_out, ".txt")
  # Read the results
  #res_file <- LR_out
  #LR_results <- read.delim(res_file, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
  LR_results <- LR_out
  
  LR_results_p05 <- LR_results %>%  filter(PVAL < 0.05)
  #LR_results_p05 <- LR_results
  #head(LR_results)
  LR_results_p05$MAF <- 1 -  LR_results_p05$AF 
  # Beta - SCORE/VAR
  LR_results_p05$Beta <- -(LR_results_p05$SCORE)/LR_results_p05$VAR
  
  # SCORE/VAR
  LR_results_p05$Z <- -(LR_results_p05$SCORE)/sqrt(LR_results_p05$VAR)
  
  # SE=1/Sqrt(VAR)
  LR_results_p05$SE <- 1/sqrt(LR_results_p05$VAR)
  
  # OR=EXP(Beta)
  LR_results_p05$OR <- exp(LR_results_p05$Beta)
  
  # EXP(L2-1.96*N2)
  LR_results_p05$Low95 <- exp(LR_results_p05$Beta - 1.96*LR_results_p05$SE)
  
  # EXP(L2+1.96*N2)
  LR_results_p05$Up95 <- exp(LR_results_p05$Beta + 1.96*LR_results_p05$SE)
  
  #LR_results_p05 <- LR_results_p05 %>% arrange(PVAL) %>% desc(OR)
  print(dim(LR_results_p05))
  return(LR_results_p05)
  # head(LR_results_p05)
  
}


LR_results_stat_of_minor <- function(LR_out, out_df) {
  require(dplyr)
  #res_file <- paste0(LR_out, ".txt")
  # Read the results
  #res_file <- LR_out
  #LR_results <- read.delim(res_file, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
  LR_results <- LR_out
  
  LR_results_p05 <- LR_results %>%  filter(PVAL < 0.05)
  #LR_results_p05 <- LR_results
  #head(LR_results)
  LR_results_p05$MAF <- LR_results_p05$AF 
  # Beta - SCORE/VAR
  LR_results_p05$Beta <- (LR_results_p05$SCORE)/LR_results_p05$VAR
  
  # SCORE/VAR
  LR_results_p05$Z <- (LR_results_p05$SCORE)/sqrt(LR_results_p05$VAR)
  
  # SE=1/Sqrt(VAR)
  LR_results_p05$SE <- 1/sqrt(LR_results_p05$VAR)
  
  # OR=EXP(Beta)
  LR_results_p05$OR <- exp(LR_results_p05$Beta)
  
  # EXP(L2-1.96*N2)
  LR_results_p05$Low95 <- exp(LR_results_p05$Beta - 1.96*LR_results_p05$SE)
  
  # EXP(L2+1.96*N2)
  LR_results_p05$Up95 <- exp(LR_results_p05$Beta + 1.96*LR_results_p05$SE)
  
  #LR_results_p05 <- LR_results_p05 %>% arrange(PVAL) %>% desc(OR)
  print(dim(LR_results_p05))
  return(LR_results_p05)
  # head(LR_results_p05)
  
}
# Create an empty data frame to store the result
LR_results_p05_df <- data.frame()

# Call the function and assign the result to NS_EOAD_stat
#NS_EOAD_stat <- LR_results_stat("results/Association_results/NS_EOAD_492_mem_SNPs_Sept14_out", LR_results_p05_df)
#head(NS_EOAD_stat)
#dim(NS_EOAD_stat)

# pval <0.05
#NS_EOAD_stat_05P_ORgt1_ord
# 4289   17


NS_EOAD_stat <- read.table("results/Association_results/NS_EOAD_492_mem_SNPs_Sept14_out.txt", header = T)
dim(NS_EOAD_stat)
# 97701    11

NS_EOAD_stat_g05 <- NS_EOAD_stat %>%  filter(AF >= 0.5)
dim(NS_EOAD_stat_g05)
# 97685    11
NS_EOAD_stat_g05_df <- data.frame()
NS_EOAD_stat_g05_cal <-  LR_results_stat(NS_EOAD_stat_g05, NS_EOAD_stat_g05_df)
dim(NS_EOAD_stat_g05_cal)
# 4684   18



NS_EOAD_stat_l05 <- NS_EOAD_stat %>%  filter(AF < 0.5) 
dim(NS_EOAD_stat_l05)
# 55184    11
NS_EOAD_stat_l05_df <- data.frame()

NS_EOAD_stat_l05_cal <- LR_results_stat_of_minor(NS_EOAD_stat_l05, NS_EOAD_stat_l05_df)

dim(NS_EOAD_stat_l05_cal)
# 1 18







head(LR_results_p05_df)
NS_EOAD_stat_01P_ORgt1 <- NS_EOAD_stat %>% filter(PVAL < 0.01 & OR >1.0)
head(NS_EOAD_stat_01P_ORgt1)
dim(NS_EOAD_stat_01P_ORgt1)
# 804  18
min(NS_EOAD_stat_01P_ORgt1$PVAL)
# 3.89e-06

# Frequency
EOAD_492_frq <- read.delim("results/plink_ASSOC/EOAD/Freq_MAF_NS_EOAD_492_mem_SNPs.frq.txt", sep="\t")
head(EOAD_492_frq)
# CHR              SNP A1 A2     MAF NCHROBS
# 1   1  chr1:973929:T:C  C  T 0.27440     164
# 2   1 chr1:1014228:G:A  A  G 0.25000     164
# 3   1 chr1:1374025:T:C  C  T 0.09146     164
# 4   1 chr1:1399095:G:C  C  G 0.05488     164
# 5   1 chr1:1420203:C:A  A  C 0.12200     164
# 6   1 chr1:1426261:C:T  T  C 0.17280     162
dim(EOAD_492_frq)
# 97701     6
sum(NS_EOAD_stat_01P_ORgt1$SNP %in% EOAD_492_frq$SNP)
# 804

# Assoc from Plink
EOAD_492_assoc <- read.csv("results/plink_ASSOC/EOAD/Assoc_NS_EOAD_492_mem_SNPs.assoc.csv")
head(EOAD_492_assoc)

EOAD_grp <- read.csv("data/EOAD_grp.csv", row.names=1)
dim(EOAD_grp)
# 492  28
head(EOAD_grp)

EOAD_492_n_assoc_df <- left_join(NS_EOAD_stat_01P_ORgt1, EOAD_492_assoc, by= "SNP")
head(EOAD_492_n_assoc_df)

EOAD_492_n_assoc_freq_df <- left_join(EOAD_492_n_assoc_df, EOAD_492_frq, by="SNP")
head(EOAD_492_n_assoc_freq_df)
dim(EOAD_492_n_assoc_freq_df)
# 804  35

## *****************************************************************************
## Non-synonymous Annotation
##  ****************************************************************************
nonsyn_snps_annot <- read.delim("../nonsyn_snps.txt", header=F, sep = "\t")
head(nonsyn_snps_annot)
EOAD_492_risk_anno <- nonsyn_snps_annot[nonsyn_snps_annot$V10 %in% EOAD_492_n_assoc_freq_df$SNP, ]
dim(EOAD_492_risk_anno)

EOAD_492_risk_anno
EOAD_492_anno_df <- left_join(EOAD_492_n_assoc_freq_df, EOAD_492_risk_anno, by=c("SNP" = "V10"))
dim(EOAD_492_anno_df)
# 804  44





EOAD_492_risk_table <- EOAD_492_anno_df %>% dplyr::select("CHR" = "CHR.x", SNP, POS, 
                                                          "Gene" = "V6", "A1(alt)"="A1.x",
                                                          "A2(ref)"="A2.x",  
                                                           N, "MAF" = "MAF.x", 
                                                          PVAL, "OR"="OR.x", F_A , F_U)

EOAD_492_risk_table

summary(EOAD_492_risk_table$OR)
# Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
# 2        18       134   7599432      2896 621501108 
# 

EOAD_492_causal <-  EOAD_492_risk_table %>% filter(PVAL < 0.01 & F_A > F_U)
dim(EOAD_492_causal)
# 804  12
EOAD_492_causal_OR <- EOAD_492_causal %>% filter(OR > 1.0)
dim(EOAD_492_causal_OR)
# 804  12


EOAD_492_causal_OR_001 <- EOAD_492_causal_OR %>% filter(PVAL < 0.001)
dim(EOAD_492_causal_OR_001)
# 136  12
write.csv(EOAD_492_causal_OR_001, file="results/EOAD_492_causal_OR_001.csv")

EOAD_492_causal_OR_001
summary(EOAD_492_causal_OR_001$CHR)
levels(as.factor(EOAD_492_causal_OR_001$CHR))
EOAD_492_causal_OR_0001 <- EOAD_492_causal_OR %>% filter(PVAL < 0.0001)
dim(EOAD_492_causal_OR_0001)
# 56 12
EOAD_492_causal_OR_001 <- nonsyn_snps_annot[nonsyn_snps_annot$V10 %in% EOAD_492_n_assoc_freq_df$SNP, ]
EOAD_492_causal_OR_001
write.csv(EOAD_492_causal_OR_001, file="results/EOAD_492_causal_OR_001.csv")

cerc6 <- 'chr22:17119540:C:G'
EOAD_492_causal_OR_001$cerc6 %in% nonsyn_snps_annot$V10

## *************************************************
fEOAD_table
sEOAD_fEOAD_risk_table <- sEOAD_fEOAD_risk %>% dplyr::select(SNP, N, "MAF"="MAF.x", PVAL, "OR"="OR.x")
sEOAD_fEOAD_risk_table
LOAD_risk_table <- fEOAD_risk_sEOAD_LOAD_df %>% dplyr::select(SNP, N, "MAF"="MAF.x", PVAL, "OR"="OR.x")

LOAD_risk_table
fEOAD_table_sEOAD <- left_join(fEOAD_table, sEOAD_fEOAD_risk_table, by = "SNP")
fEOAD_table_sEOAD
fEOAD_table_sEOAD_LOAD <- left_join(fEOAD_table_sEOAD, LOAD_risk_table, by = "SNP")
write.csv(fEOAD_table_sEOAD_LOAD, file="results/fEOAD_table_sEOAD_LOAD.csv")

hg38_HEADER <- read.delim("results/CH022_anvr.anno.hg38_HEADER.txt", header=T, sep = "\t")
hg38_HEADER
colnames(hg38_HEADER)
NS_hg38_multi <- read.delim("results/NS_CHR_1_22_anno_hg38_multi.txt")
colnames(NS_hg38_multi) <- colnames(hg38_HEADER)
head(NS_hg38_multi)
fEOAD_table_cadd_1 <- NS_hg38_multi %>% filter(Chr ==  1  & Start == "92483381" ,
                                               Chr ==  1  & Start == "111312267", 
                                               Chr ==  1  & Start == "111312273" )

fEOAD_table_cadd_1
save.image(file="data/workspace_Sept_8.RData")
