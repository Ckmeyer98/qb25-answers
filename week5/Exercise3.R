library(tidyverse)
library(broom)
library(tibble)
library(dplyr)
library(readr)

#Retrieve Pokemon Dataset

pokemon_df <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-01/pokemon_df.csv')

#Take sum of all 6 Pokemon stats to produce new "Base Stat Total" column, for a more balanced measure of Pokemon "power"

pokemon_df <- pokemon_df %>%
  mutate(Base_Stat_Total = rowSums(across(c(hp, attack, defense, special_attack, special_defense, speed)), na.rm = TRUE))

#Generate scatter plot comparing base stat total to generation number to see if Pokemon have become more powerful over the course of the franchise.

ggplot(pokemon_df, aes(x = generation_id, y = Base_Stat_Total)) +
  geom_point(color = "tomato", size = 3, alpha = 0.7) +
  labs(
    x = "Pokemon Species Number",
    y = "Pokemon Power (Sum of Stats)",
  )

#Generate scatter plot comparing Pokemon weight to base stat total - are larger Pokemon more powerful?

ggplot(pokemon_df, aes(x = Base_Stat_Total, y = weight)) +
  geom_point(color = "tomato", size = 3, alpha = 0.7) +
  labs(
    x = "Pokemon Power (Sum of Stats)",
    y = "Pokemon Weight",
  )

ggsave("ex4_bst_w.png", width = 6, height = 4, dpi = 300)

#Linear Regression Model

pokemon_model <- lm(Base_Stat_Total ~ weight, data = pokemon_df)

pokemon_OLS <- tidy(pokemon_model)
