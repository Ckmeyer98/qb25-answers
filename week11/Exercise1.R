library(ggplot2)

setwd("/Users/cmdb/qb25-answers/week11")

# Read coverage
Coverage <- scan("coverage_1Mbp_100bp_30x.txt")

max_Coverage <- max(Coverage)

hist(Coverage,
     breaks = seq(-0.5, max_Coverage + 0.5, by = 1),
     freq = FALSE,
     main = "Genome coverage histogram (30x) with Poisson and Normal overlays",
     xlab = "Coverage (reads per bp)",
     xlim = c(0, max_Coverage))

# Overlay Poisson
k <- 0:max_Coverage
pois_p <- dpois(k, lambda = 30)
lines(k, pois_p, type = "b", pch = 16)

# Overlay Normal
x <- seq(0, max_Coverage, length.out = 1000)
norm_d <- dnorm(x, mean = 30, sd = 5.47)
lines(x, norm_d, lwd = 2)

legend("topright",
       legend = c("Histogram (density)", "Poisson(λ=30)", "Normal(μ=30, σ=5.47)"),
       lty = c(NA, 1, 1),
       pch = c(15, 16, NA),
       pt.cex = c(1.5, 1, NA),
       bty = "n")

ggsave("ex1_30x_cov.png")