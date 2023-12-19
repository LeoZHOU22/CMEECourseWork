# CMEE 2022 HPC exercises R code pro forma
# For neutral model cluster run

rm(list=ls()) 
graphics.off()

source("/rds/general/user/lz723/home/LZ723/lz723_HPC_2023_main.R")



# Read in the job number from the cluster
# Uncomment below line when running on the cluster
iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))

# For local testing, comment out the above line and use the following line
#iter <- 1  # Example for testing, change iter for different simulations

# Control the random number seeds
set.seed(iter)

# Select the community size based on iter
if (iter >= 1 && iter <= 25) {
  size <- 500
} else if (iter >= 26 && iter <= 50) {
  size <- 1000
} else if (iter >= 51 && iter <= 75) {
  size <- 2500
} else if (iter >= 76 && iter <= 100) {
  size <- 5000
}

# Define other parameters
speciation_rate <- 0.005545 #lz723
interval_rich <- 1
interval_oct <- size / 10
burn_in_generations <- 8 * size
wall_time <- 11.5 * 60  # 11.5 hours in minutes

# Create a filename for the output
output_file_name <- paste("simulation_result_", iter, ".rda", sep = "")

# Call the neutral_cluster_run function
neutral_cluster_run(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)
