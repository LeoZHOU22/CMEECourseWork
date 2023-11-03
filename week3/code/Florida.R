rm(list=ls())

load("../data/KeyWestAnnualMeanTemperature.RData")

ls()
# Calculate the observed correlation coefficient between years and temperature
observed_correlation <- cor(ats$Year, ats$Temp)
# Permutation analysis
num_permutations <- 10000
random_correlations <- numeric(num_permutations)

for (i in 1:num_permutations) {
  shuffled_temperature <- sample(ats$Temp)
  random_correlations[i] <- cor(ats$Year, shuffled_temperature)
}

# Calculate the fraction of random correlation coefficients greater than the observed one
p_value <- sum(random_correlations >= observed_correlation) / num_permutations

# Save the results to be used in the LaTeX document
write.csv(data.frame(Observed_Correlation = observed_correlation, P_Value = p_value), "florida_results.csv", row.names = FALSE)

