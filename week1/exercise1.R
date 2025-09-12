library(tidyverse)

header <- c( "chr", "start", "end", "count")

df_kc <- read_tsv("/Users/cmdb/qb25-answers/week1/hg19-kc-count.bed", col_names=header)


ggplot(df_kc, aes(x = start, y = count)) +
  geom_line() +
  facet_wrap(chr ~ ., scales = 'free') +
  labs(
    x = "Position",
    y = "Gene Density",
    title = "Gene Density Across Chromosomes"
  )
ggsave( "exercise1.png")
