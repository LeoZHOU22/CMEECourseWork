# Runs the stochastic Ricker equation with gaussian fluctuations

rm(list = ls())

stochrickvect <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2, numyears = 100) {
  N <- matrix(NA, numyears, length(p0))  # Initialize empty matrix
  N[1, ] <- p0

  for (yr in 2:numyears) {
    growthFactor <- exp(r * (1 - N[yr - 1, ] / K) + rnorm(length(p0), 0, sigma))
    N[yr, ] <- N[yr - 1, ] * growthFactor
  }

  return(N)
}

# Check the performance of the vectorized function
print("Vectorized Stochastic Ricker takes:")
print(system.time(res2 <- stochrickvect()))