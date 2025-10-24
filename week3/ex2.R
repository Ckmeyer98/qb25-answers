library(ggplot2)

af_data <- read.table("./qb25-answers/week3/AF.txt", header = TRUE)
AF <- af_data[[1]]
AF <- AF[is.finite(AF) & AF >= 0 & AF <= 1]

ggplot(data.frame(AF = AF), aes(x = AF)) +
  geom_histogram(bins = 11, fill = "cornflowerblue", color = "white") +
  labs(title = "Allele Frequency Spectrum",
       x = "Allele Frequency (AF)",
       y = "Number of Variants")

# The data are not what I expected, as I expected more variants to have a lower allele frequency
# as I expected many variants to be more rare. The distribution is Gaussian, and seems to
# indicate most variants are roughly 50/50.

dp_data <- read.table("./qb25-answers/week3/DP.txt", header = TRUE)
DP <- as.numeric(dp_data[[1]])
DP <- DP[is.finite(DP) & DP >= 0]
DP[DP > 20] <- 20

ggplot(data.frame(DP = DP), aes(x = DP)) +
  geom_histogram(bins = 21, fill = "seagreen3", color = "white") +
  coord_cartesian(xlim = c(0, 20)) +
  labs(title = "Distribution of Read Depth Across All Samples and Variants",
       x = "Read Depth (DP)",
       y = "Number of Observations")


# This distribution is strongly right-skewed; this distribution indicates that 
# most sites have low/medium depth, while a small number of sites have a high number.
# This distribution makes sense due to the inherent randomness of sequencing - not
# all sites will be read the same number of times