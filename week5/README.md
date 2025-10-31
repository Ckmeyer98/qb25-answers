Step 2.2 — OLS: maternal age vs. maternal DNMs

1. What is the “size” (i.e., slope) of this relationship? Interpret the slope in plain language. Does it match your plot?

Answer: Based on the linear regression model, the slope is 0.37. This means that for every 1 year increase in maternal age, you can expect
0.37 more DNMs. This matches my plot, as I observe a positive correlation between the two variables, with a slow, gradual increase.

2. Is the relationship significant? How do you know? Explain the p-value in plain but precise language.

Answer: The relationship is significant, as the p-value is 6.878208e-24, which is well below the p = 0.05 cutoff. This means that there is a less
than 5% chance that there is no relationship (slope = 0) and that these data occurred by chance.

Step 2.3 — OLS: paternal age vs. paternal DNMs

1. What is the “size” (i.e., slope) of this relationship? Interpret the slope in plain language. Does it match your plot?

Answer: Based on the linear regression model, the slope is 1.35. This means that for every 1 year increase in paternal age, you can expect
1.35 more DNMs. This matches my plot, as I observe a positive correlation between the two variables, with a slow, gradual increase. In the context of the maternal plot, it makes sense that the slope is higher when looking at parental data, since the plot appears to display a sharper slope

2. Is the relationship significant? How do you know? Explain the p-value in plain but precise language.

Answer: The relationship is significant, as the p-value is 1.552294e-84, which is well below the p = 0.05 cutoff, even smaller than the maternal data. This means that there is a less than 5% chance that there is no relationship (slope = 0) and that these data occurred by chance.

Step 2.4 — Predict for a 50.5-year-old father

Use the paternal regression model to predict the expected number of paternal DNMs for a father of age 50.5. 

Answer: I used the following commands in R:

New_Paternal <- data.frame(Father_age = 50.5)
Paternal_predicted <- predict(paternal_model, newdata = New_Paternal)

Then when calling "Paternal_predicted" it returns 78.69546, indicating that you'd predict a father of 50.5 years old to have a child of about 79 paternal DNMs.

Step 2.6 — Statistical test: maternal vs. paternal DNMs per proband

1. What is the “size” of this relationship (i.e., the average difference in counts of maternal and paternal DNMs)?

Answer: The mean differences value from the t-test was -39.23485, indicating that there are about 39 more paternal DNMs than maternal DNMs in each sample.

2. Is the relationship significant? How do you know? Explain the p-value in plain but precise language.

Answer: The relationship is significant, as the p-value is 2.2e-16, which is well below the p = 0.05 cutoff. This means that there is a less than 5% chance that there is no real difference between number of maternal and paternal DNMs and that these data occurred by chance.

Step 3.1 — Pick a TidyTuesday dataset

I have chosen the Pokemon dataset.

Step 3.2 — Explore and visualize

I added a column to the dataset for the Base Stat Total (BST) - the sum of the 6 Pokemon stats (Hit Points(HP), Attack, Defense, Special Attack, Special Defense, and Speed) as a measure of how powerful a pokemon is in battle.

Next, I tested whether BST was higher in later generations with a scatter plot, in order to assess whether there was any "power creep" that caused Pokemon to get progressively stronger. However, there didn't seem to be any apparent trend.

Instead, I then decided to generate a scatter plot of BST and weight to see whether larger pokemon were generally more powerful. These variables appear to be positively correlated.

Step 3.3 — Pose and test a linear-model hypothesis

Hypothesis: Larger Pokemon have higher stats

Linear Model (BST VS Weight) Results: slope: 0.465331 p value: 1.007573e-53. 

This model indicate there is a small, but significant positive correlation between pokemon stats and size. The slope indicates that for every 0.47 kg increase in weight, you'd expect a pokemon to have a BST increase of 1. The p-value is also very low, much below 0.05, indicating that the slope is significantly different from 0 and there is a very low likelihood that the trend is occurring by chance.
