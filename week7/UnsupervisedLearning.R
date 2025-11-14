library(tidyverse)
library(dplyr)
library(matrixStats)

setwd("/Users/cmdb/qb25-answers/week7")

seq_matrix <- as.matrix(read.table("read_matrix.tsv",
                                   sep = "\t",
                                   header = TRUE,
                                   stringsAsFactors = FALSE))

seq_matrix_copy <- seq_matrix

#Focus on most variable genes

gene_sds <- rowSds(seq_matrix_copy)

gene_order <- order(gene_sds, decreasing = TRUE)[1:500]

gene_top500 <- seq_matrix_copy[gene_order, ]

#Run PCA

pca_top500 <- prcomp(t(gene_top500), scale. = TRUE)

pca_df <- as.data.frame(pca_top500$x) %>%
  rownames_to_column(var = "sample") %>%  
  select(sample, PC1, PC2)

pca_df <- pca_df %>%
  separate(sample, into = c("tissue", "replicate"), sep = "_")

#Plot PC1 and PC2

ggplot(pca_df, aes(x = PC1, y = PC2,
                   color = tissue,
                   shape = replicate)) + 
  geom_point(size = 3) +
  labs(x = "PC1",
       y = "PC2",
       color = "Tissue",
       shape = "Replicate",
       title = "PCA of top 500 most variable genes")

ggsave("Exercise_1.3_PCA.png")

#Variance explained by each PC

var_explained <- (pca_top500$sdev^2) / sum(pca_top500$sdev^2)

var_df <- tibble(
  PC = paste0("PC", seq_along(var_explained)),
  variance = var_explained
)

ggplot(var_df, aes(x = PC, y = variance)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(
    x = "Principal Component",
    y = "Proportion of Variance Explained"
  )

ggsave("Exercise_1.3_Var.png")

#Average replicates

combined = seq_matrix[,seq(1, 21, 3)]
combined = combined + seq_matrix[,seq(2, 21, 3)]
combined = combined + seq_matrix[,seq(3, 21, 3)]
combined = combined / 3

combined_sd <- rowSds(as.matrix(combined))

combined_filtered <- combined[combined_sd > 1, ]

#k-means clustering

set.seed(42)

k_res <- kmeans(combined_filtered,
                centers = 12,
                nstart  = 100)

gene_clusters <- k_res$cluster

stopifnot(all(names(gene_clusters) == rownames(combined_filtered)))

cluster_order <- order(gene_clusters)

expr_sorted <- combined_filtered[cluster_order, ]

clusters_sorted <- gene_clusters[cluster_order]

#Heatmap

heatmap(expr_sorted, Rowv=NA, Colv=NA, RowSideColors=RColorBrewer::brewer.pal(12,"Paired")[clusters_sorted], ylab="Gene")

ggsave("Exercise_2.2_Heat_map.png")

#GO Enrichment Analysis

cluster_A <- 12

genes_cluster_A <- rownames(combined_filtered)[gene_clusters == cluster_A]

write.table(
  genes_cluster_A,
  file = "genes_cluster_A.txt",
  quote = FALSE,
  row.names = FALSE,
  col.names = FALSE
)

cluster_B <- 4

genes_cluster_B <- rownames(combined_filtered)[gene_clusters == cluster_B]

write.table(
  genes_cluster_B,
  file = "genes_cluster_B.txt",
  quote = FALSE,
  row.names = FALSE,
  col.names = FALSE
)
