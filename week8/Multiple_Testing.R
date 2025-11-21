library(DESeq2)
library(tidyverse)
library(broom)

setwd("/Users/cmdb/qb25-answers/week8")

# Load in data and metadata as tibbles

counts_df <- read_delim("gtex_whole_blood_counts_downsample.txt")

metadata_df <- read_delim("gtex_metadata_downsample.txt")

locations_df <- read_delim("gene_locations.txt")

# Make data numeric

counts_df <- column_to_rownames(counts_df, var = "GENE_NAME")

metadata_df <- column_to_rownames(metadata_df, var = "SUBJECT_ID")

# Confirm order is consistent

all(colnames(counts_df) == rownames(metadata_df))

#create DESeq2 object, including the variables SEX, DTHHRDY, and AGE

dds <- DESeqDataSetFromMatrix(countData = counts_df,
                              colData = metadata_df,
                              design = ~ SEX + AGE + DTHHRDY)

# Apply VST to DESeq2 object

vsd <- vst(dds)

# PCA VST-normalized data (sex)

plotPCA(vsd, intgroup = "SEX")

ggsave("VST_Sex.png")

# PCA VST-normalized data (age)

plotPCA(vsd, intgroup = "AGE")

ggsave("VST_Age.png")

# PCA VST-normalized data (DTHHRDY)

plotPCA(vsd, intgroup = "DTHHRDY")

ggsave("VST_DTHHRDY.png")

# What proportion of variance in the gene expression data is explained by each 
# of the first two principal components? Which principal components appear to be
# associated with which subject-level variables?

# Answer: PC1 explains 48% of the variance in the data and PC2 explains 7%
# PC1 seems to be most closely associated with cause of death.

# Extract VST expression matrix and bind to metadata

vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()

vsd_df <- bind_cols(metadata_df, vsd_df)

# Differential expression of WASH7P gene

m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()

# Does WASH7P show significant evidence of sex-differential expression (and if
# so, in which direction)?

# Answer: WASH7P does not appear to have significant sex-differential expression
# since the p-value (7.108770e-01) exceeds the 0.05 threshold

#Repeat analysis for SLC25A47

m2 <- lm(formula = SLC25A47 ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()

# Does SLC25A47 show evidence of sex-differential expression (and if so, in
# which direction)?

# Answer: SLC25A47 shows evidence of significant (p = 0.026) sex-differential
# expression that is greater in males, albeit by a small magnitude
# (estimate = 0.52)

# Differential expression analysis

dds <- DESeq(dds)

# Extract the differential expression results for the variable SEX.

res <- results(dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")
  filter(padj < 0.1)

# How many genes exhibit significant differential expression between males and
# females at a 10% FDR?

# Answer: 262 genes exhibit significant differential expression between males
# and females

# Add mappings of genes to chromosomes

merged_de <- res %>% 
  left_join(locations_df, by = "GENE_NAME") %>% 
  arrange(padj)

# Which chromosomes encode the genes that are most strongly upregulated in males
# versus females, respectively? Are there more male-upregulated genes or 
# female-upregulated genes near the top of the list?

# Answer: Chromosome Y encodes the genes that are most strongly upregulated in
# males, while Chromosome X encodes the genes that are most strongly upregulated
# in females. There seems to be mostly male-upregulated genes on Chromosome Y
# at the top of the list. Since females lack a Y Chromosome, perhaps this
# discrepancy could explain the strength of the upregulation of these genes in
# males.

# Examine the results for the two genes (WASH7P and SLC25A47) that you had 
# previously tested with the basic linear regression model in step 2.1. Are the
# results broadly consistent?

# Answer: The results for WASH7P and SLC25A47 seem to be consistent with the
# results of the linear regression model, as just like in that model, WASH7P
# is not significantly differently expressed, but SLC25A47 is.

# In your written interpretation of results, add a short reflection on how your
# analysis illustrates the trade-off between false positives and false negatives.

# Answer: Using a more stringent FDR threshold, such as 1%, could result in
# false negatives as differently expressed genes could not be counted. Similarly,
# a more lenient threshold, such as 20%, could result in some false positives,
# as there is more potential for differences in expression to have occurred by
# chance. If there is a small effect size, you might need a larger sample size
# in order to detect the difference with sufficient statistical power.

# Repeat analysis with death classification as variable of interest

res_death <- results(dds, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes")  %>%
  as_tibble(rownames = "GENE_NAME") %>%
  filter(padj < 0.1)

# How many genes are differentially expressed according to death classification at a 10% FDR?

#Answer: 16069 genes are differently expressed according to death classification.

# Randomly permute sex column from metadata

metadata_df_permuted <- metadata_df %>%
  mutate(SEX = sample(SEX))

# Rerun DESeq2 analysis with permuted variable

dds_permuted <- DESeqDataSetFromMatrix(countData = counts_df,
                              colData = metadata_df_permuted,
                              design = ~ SEX + AGE + DTHHRDY)

vsd_permuted <- vst(dds_permuted)

vsd_df_permuted <- assay(vsd_permuted) %>%
  t() %>%
  as_tibble()

vsd_df_permuted <- bind_cols(metadata_df_permuted, vsd_df)

dds_permuted <- DESeq(dds_permuted)

res_permuted <- results(dds_permuted, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME") %>%
  filter(padj < 0.1)

# How many genes appear “significant” in this permuted analysis at a 10 % FDR?

# Answer: Only 16 genes appear as significant false positives here. This is much
# lower than the 262 detected in the non-permuted data, indicating that a 10%
# FDR is sufficient to keep false positives at a low level.

# Volcano Plot of differential expression results from 2.3

# Classify genes by padj + fold change for color scheme

volcano_df <- res %>%
  mutate(
    highlight = case_when(
      padj < 0.10 & abs(log2FoldChange) > 1 ~ "Significant",
      TRUE                                  ~ "Not Significant"
    ),
    neg_log10_padj = -log10(padj)
  )

ggplot(volcano_df,
       aes(x = log2FoldChange, y = neg_log10_padj, color = highlight)) +
  geom_point() +
  scale_color_manual(values = c(
    "Not Significant" = "grey60",
    "Significant"     = "red")) +
  labs(
    x = "log2(fold change)",
    y = "-log(adjusted p-value)",
    color = "Gene status"
  )
  
ggsave("DESeq_Volcano.png")
