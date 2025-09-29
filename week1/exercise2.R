library(tidyverse)

header <- c( "chr", "start", "end", "count")

df_kc_19 <- read_tsv("/Users/cmdb/qb25-answers/week1/hg19-kc-count.bed", col_names=header)

df_kc_16 <- read_tsv("/Users/cmdb/qb25-answers/week1/hg16-kc-count.bed", col_names=header)


ggplot(bind_rows( hg19=df_kc_19, hg16=df_kc_16, .id="assembly" ), aes(x = start, y = count, color = assembly)) +
  geom_line() +
  facet_wrap(chr ~ ., scales = 'free') +
  labs(
    x = "Position",
    y = "Gene Density",
    title = "Gene Density Across Chromosomes"
  )

