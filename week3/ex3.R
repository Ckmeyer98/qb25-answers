library(ggplot2)

gt <- read.table("./qb25-answers/week3/gt_long.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

df <- subset(gt, sample_id == "A01_62" & chrom == "chrII")

df$pos <- suppressWarnings(as.numeric(df$pos))
df <- df[is.finite(df$pos) & df$genotype %in% c("0", "1"), ]

# Converting genotype to a factor
df$genotype <- factor(df$genotype, levels = c("0", "1"))

ggplot(df, aes(x = pos, y = 0, color = genotype)) +
  geom_point(size = 0.8, alpha = 0.9) +
  scale_color_manual(values = c("steelblue3", "tomato"), name = "Genotype") +
  labs(
    title = "Genotype Track (A01_62, ChrII)",
    x = "Position (bp)",
    y = NULL )

#For all chromosomes:

gt <- gt[gt$genotype %in% c("0", "1"), ]
gt$genotype <- factor(gt$genotype, levels = c("0", "1"))
gt$pos <- suppressWarnings(as.numeric(gt$pos))
gt <- gt[is.finite(gt$pos), ]

gt$chrom <- factor(gt$chrom, levels = unique(gt$chrom))

df_62 <- subset(gt, sample_id == "A01_62")

p_62 <- ggplot(df_62, aes(x = pos, y = sample_id, color = genotype)) +
  geom_point(size = 0.8, alpha = 0.9) +
  facet_grid(~ chrom, scales = "free_x", space = "free_x") +
  labs(title = "Genotype track for A01_62 across chromosomes",
       x = "Position (bp)", y = NULL) +
  scale_color_manual(values = c("steelblue3", "tomato"), name = "Genotype")
p_62

# All samples

p_all <- ggplot(gt, aes(x = pos, y = sample_id, color = genotype)) +
  geom_point(size = 0.6, alpha = 0.9) +
  facet_grid(~ chrom, scales = "free_x", space = "free_x") +
  labs(title = "Genotype tracks across chromosomes (all samples)",
       x = "Position (bp)", y = NULL) +
  scale_color_manual(values = c("steelblue3", "tomato"), name = "Genotype")
p_all


# Question 3.1: A01_27, A01_31, and A01_63 are strong candidates for the wine strains,
# as they have many different alleles from the reference genome.
# Question 3.2: Different genotypes occur together in blocks. Sites of change between
# red and blue could be loci where recombination occurred.
  