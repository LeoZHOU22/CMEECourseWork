# Clear the workspace and turn off any existing graphics to start fresh
rm(list = ls())
graphics.off()

# Load the required functions from the main script
source("/rds/general/user/lz723/home/LZ723/lz723_HPC_2023_main.R")  

# Retrieve the job number from the cluster environment variable
iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))

# Set a unique random seed for each simulation run to ensure reproducibility
set.seed(iter)

# Define the projection matrix and clutch distribution as specified in question_33
growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                          0.5, 0.4, 0.0, 0.0,
                          0.0, 0.4, 0.7, 0.0,
                          0.0, 0.0, 0.25, 0.4), nrow=4, byrow=TRUE)
reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                                0.0, 0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0, 0.0), nrow=4, byrow=TRUE)
projection_matrix <- reproduction_matrix + growth_matrix
clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)

# Define the simulation parameters: length and number of repetitions
simulation_length <- 120
simulation_times = 150

# Assign one of the four initial conditions to each set of simulations based on the iter value
if (iter <= 25) {
  initial_state <- state_initialise_adult(4, 100)  # Large population of 100 adults
} else if (iter <= 50) {
  initial_state <- state_initialise_adult(4, 10)   # Small population of 10 adults
} else if (iter <= 75) {
  initial_state <- state_initialise_spread(4, 100) # Large mixed population of 100 individuals
} else {
  initial_state <- state_initialise_spread(4, 10)  # Small mixed population of 10 individuals
}

# Set the output filename based on the iter value
output_file_name <- paste("stochastic_", iter, ".rda", sep="")

# Run the simulations and store the results
simu_results <- list()
for (i in 1:simulation_times) {
  simu_results[[i]] <- stochastic_simulation(initial_state, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length)
}

# Save the simulation results to a file
save(simu_results, file = output_file_name)



