# ==================================================
# R Script: mtcars_analysis.R
# Author: Baraka Mitigoa
# Purpose: Analyze and visualize the built-in mtcars dataset
# ==================================================

# 1. Load Libraries
library(tidyverse)
library(ggplot2)
library(dplyr)

# 2. Load Dataset
data("mtcars")
df <- mtcars

# 3. Inspect the Data
head(df)
summary(df)
str(df)

# 4. Add car names as a column
df <- df %>% 
  mutate(Car = rownames(mtcars)) %>% 
  relocate(Car)

# 5. Descriptive Statistics
summary(df$mpg)
mean(df$hp)
sd(df$qsec)

# 6. Data Visualization

# A. Histogram of Miles Per Gallon (mpg)
ggplot(df, aes(x = mpg)) +
  geom_histogram(binwidth = 2, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Miles Per Gallon (mpg)",
       x = "Miles Per Gallon (mpg)", y = "Count") +
  theme_minimal()

# B. Relationship between Horsepower and MPG
ggplot(df, aes(x = hp, y = mpg)) +
  geom_point(color = "steelblue") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Relationship between Horsepower and MPG",
       x = "Horsepower (hp)", y = "Miles Per Gallon (mpg)") +
  theme_minimal()

# C. Boxplot of MPG by Number of Cylinders
ggplot(df, aes(x = factor(cyl), y = mpg, fill = factor(cyl))) +
  geom_boxplot() +
  labs(title = "MPG Distribution by Cylinder Count",
       x = "Number of Cylinders", y = "Miles Per Gallon (mpg)") +
  theme_minimal()

# 7. Regression Model: Predict MPG
model <- lm(mpg ~ hp + wt + cyl, data = df)
summary(model)

# 8. Evaluate the Model
pred <- predict(model, df)
cor(pred, df$mpg)

# 9. Save Outputs
write.csv(df, "cleaned_mtcars_data.csv", row.names = FALSE)
saveRDS(model, "mtcars_model.rds")

# 10. Save Plots
ggsave("mpg_histogram.png", width = 7, height = 5)
ggsave("hp_vs_mpg.png", width = 7, height = 5)
ggsave("mpg_by_cyl.png", width = 7, height = 5)

cat("\n✅ MTCARS Analysis Complete! Data, Model, and Plots saved successfully.\n")
