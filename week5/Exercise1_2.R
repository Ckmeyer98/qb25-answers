library(tidyverse)
library(broom)
library(tibble)
library(dplyr)
library(readr)

#Load aau1043_dm.csv as tibbles

aau1043_tibble <- as_tibble(read.csv("/Users/cmdb/qb25-answers/week5/aau1043_dnm.csv"))

#Create a per-proband summary with counts of maternally and paternally inherited DNMs.

summary <- aau1043_tibble %>%
  filter(Phase_combined %in% c("mother","father")) %>%
  count(Proband_id, Phase_combined, name="count") %>%
  pivot_wider(names_from=Phase_combined, values_from=count, values_fill=0)

#Load aau1043_parental_age.csv as tibble

parental_age_tibble <- as_tibble(read.csv("/Users/cmdb/qb25-answers/week5/aau1043_parental_age.csv"))

#Join the two tibbles by proband ID.

joined <- inner_join(summary, parental_age_tibble, by = "Proband_id")

#Create a scatter plot of the count of maternal DNMs vs. maternal age

ggplot(joined, aes(x = Mother_age, y = mother)) +
  geom_point(color = "steelblue", size = 3, alpha = 0.7) +
  labs(
    x = "Maternal Age (years)",
    y = "Count of Maternal DNMs",
    title = "Maternal DNM Count vs. Maternal Age"
  )

ggsave("ex2_a.png", width = 6, height = 4, dpi = 300)

#Create a scatter plot of the count of paternal DNMs vs. paternal age

ggplot(joined, aes(x = Father_age, y = father)) +
  geom_point(color = "steelblue", size = 3, alpha = 0.7) +
  labs(
    x = "Paternal Age (years)",
    y = "Count of Paternal DNMs",
    title = "Paternal DNM Count vs. Paternal Age"
  )

ggsave("ex2_b.png", width = 6, height = 4, dpi = 300)

#Fit a simple linear regression model relating maternal age to the number of maternal de novo
#mutations

maternal_model <- lm(mother ~ Mother_age, data = joined)

maternal_OLS <- tidy(maternal_model)

#repeat prior step but for paternal age vs. paternal DNMs

paternal_model <- lm(father ~ Father_age, data = joined)

paternal_OLS <- tidy(paternal_model)

#Use the paternal regression model to predict expected number of paternal DNMS for a
#father of age 50.5

New_Paternal <- data.frame(Father_age = 50.5)
Paternal_predicted <- predict(paternal_model, newdata = New_Paternal)
Paternal_predicted
#I got 78.69546 as the output

#Plot maternal and paternal DNMs on the same axes as semi-transparent histograms

dnm_long <- summary %>%
  select(Proband_id, mother, father) %>%
  pivot_longer(cols = c(mother, father),
               names_to = "origin",
               values_to = "count")

ggplot(dnm_long, aes(x = count, fill = origin)) +
  geom_histogram(alpha = 0.5, position = "identity", bins = 30, color = "black") +
  scale_fill_manual(values = c("mother" = "tomato", "father" = "steelblue")) +
  labs(
    x = "Number of De Novo Mutations (DNMs)",
    y = "Count of Probands",
    fill = "Parent of Origin",
    title = "Distribution of Maternal vs. Paternal DNMs"
)

ggsave("ex2_c.png", width = 6, height = 4, dpi = 300)

#Apply a paired t-test

t.test(joined$mother, joined$father, paired = TRUE)

#Output:

#Paired t-test

#data:  joined$mother and joined$father
#t = -61.609, df = 395, p-value < 2.2e-16
#alternative hypothesis: true mean difference is not equal to 0
#95 percent confidence interval:
#  -40.48685 -37.98284
#sample estimates:
#  mean difference 
#-39.23485 
