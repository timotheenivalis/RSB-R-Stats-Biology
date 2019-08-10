                          # R Workshop - Regression

# Author: Ananthan Ambikairajah
# Email Address: ananthan.ambikairajah@anu.edu.au; a.ambikairajah@gmail.com
# Date of File Creation: 17/04/18
# Last Edited: 11/05/18
# Edit Log: AA
# R Version: 3.3.3

# 1. Set working directory and load packages ####
setwd("~/Desktop/GitHub/CRAHW_R_Workshops/4_Simple_Linear_Regression/")

packages <- c("car", "ggplot2")
for (i in 1:length(packages)){
  library(packages[i], character.only = TRUE)
}

# 2. Exercise 1 - Advertisement and Sales####
# Load data and inspect
album_data <- read.delim("Album Sales 1.dat", header = TRUE)
head(album_data)
tail(album_data)
summary(album_data)
str(album_data)

# Simple linear regression
album_lm_0 <- lm(sales ~ 1, data = album_data); summary(album_lm_0)
album_lm_1 <- lm(sales ~ 1 + adverts, data = album_data); summary(album_lm_1)

# Using the mean as a simple model
par(mfrow = c(1,1))
plot(album_data$adverts, album_data$sales, 
     col = "blue", type = "p",
     xlab = "Amount Spent on Adverts (Thousands of Dollars)",
     ylab = "Record Sales (Thousands)",
     main = "Advertisement Investment and Number of Records Sold in 2019")
abline(h = mean(album_data$sales), col = "red", lwd = 3)

# Plot the linear regression
par(mfrow = c(1,1))
plot(album_data$adverts, album_data$sales, 
     col = "blue", type = "p",
     xlab = "Amount Spent on Adverts (Thousands of Dollars)",
     ylab = "Record Sales (Thousands)",
     main = "Advertisement Investment and Number of Records Sold in 2019")
abline(album_lm_1, col = "red", lwd = 3)

# 3. Exercise 2 - Deriving Model Output ####
# Baseline model
summary(album_lm_0)

estimate <- mean(album_data$sales); estimate
standard_error <- sd(album_data$sales)/sqrt(nrow(album_data)); standard_error
t_value <- estimate/standard_error; t_value
residuals_sales <- album_data$sales - mean(album_data$sales); residuals_sales
quantile_residuals_sales <- quantile(residuals_sales); quantile_residuals_sales
residual_standard_error <- sd(residuals_sales); residual_standard_error
lower_confint <- estimate - (1.96*standard_error); lower_confint
upper_confint <- estimate + (1.96*standard_error); upper_confint

# Simple linear regression
summary(album_lm_1)

RMSE <- sqrt(sum(residuals(album_lm_1)^2)/df.residual(album_lm_1)); RMSE # Residual Standard Error - Actually the standard deviation
R2 <- cor(album_data$adverts, album_data$sales)^2; R2
R2_adjusted <- 1 - (1 - R2)*((nrow(album_data))-1)/((nrow(album_data))-1-1); R2_adjusted
F_test <- anova(album_lm_0, album_lm_1); F_test

t_adverts <- 0.09612/0.009632; t_adverts
t_intercept <- 134.1/7.537; t_intercept

residuals <- quantile(album_lm_1$residuals); residuals

# Create a function that calculates the summary of the linear model
linear_output <- function(baseline_model, simple_linear_model, data){
  list <- list()
  
  list[["RMSE"]] <- sqrt(sum(residuals(simple_linear_model)^2)/df.residual(simple_linear_model))
  list[["R2"]] <- cor(data[,1], data[,2])^2
  list[["R2_adjusted"]] <- 1 - (1 - (cor(data[,1], data[,2])^2))*(((nrow(data))-1)/((nrow(data))-1-1))
  list[["F_test"]] <- anova(baseline_model, simple_linear_model)
  list[["t_intercept"]] <- summary(simple_linear_model)$coefficients[1,1]/summary(simple_linear_model)$coefficients[1,2]
  list[["t_predictor"]] <- summary(simple_linear_model)$coefficients[2,1]/summary(simple_linear_model)$coefficients[2,2]
  list[["Residuals"]] <- quantile(simple_linear_model$residuals)

  print(list)
}

# Test the function
linear_output(album_lm_0, album_lm_1, album_data)

# 4. Exercise 3 - Anscombe Dataset ####
anscombe_data <- read.csv("Anscombe.csv", header = TRUE)
head(anscombe_data)
tail(anscombe_data)
summary(anscombe_data)
str(anscombe_data)

# Mean and variance for all four datasets - Using a forloop

# Create empty data frame with named columns and rows
df <- data.frame(matrix(ncol = 4, nrow = 4))
x <- c("Group 1", "Group 2", "Group 3", "Group 4")
y <- c("Mean X", "Variance X", "Mean Y", "Variance Y")
rownames(df) <- x
colnames(df) <- y

df # Check empty dataframe

for(i in 1:4){
  df[i,1] <- mean(anscombe_data[anscombe_data$distri == i, "x"])
  df[i,2] <- var(anscombe_data[anscombe_data$distri == i, "x"])
  df[i,3] <- mean(anscombe_data[anscombe_data$distri == i, "y"])
  df[i,4] <- var(anscombe_data[anscombe_data$distri == i, "y"])
}

df # Check filled dataframe

# Run all four regressions - using a for loop
anscombe_lm <- list()
for(i in 1:4){
anscombe_lm[[i]] <- summary(lm(y ~ x, data = anscombe_data[anscombe_data$distri==i,]))
}
anscombe_lm

# Plot all four regressions - using a for loop
par(mfrow = c(2, 2))
for(i in 1:4){
plot(anscombe_data$x[anscombe_data$distri==i], anscombe_data$y[anscombe_data$distri==i],
     xlim=c(0,15), ylim=c(0,15),
     col = "blue", type = "p",
     xlab = "x",
     ylab = "y",
     main = paste("Distribution", i))
     intercept <- anscombe_lm[[i]][["coefficients"]][[1,1]]
     slope <- anscombe_lm[[i]][["coefficients"]][[2,1]]
     abline(a = intercept, b = slope, col = "red", lwd = 3)
}
