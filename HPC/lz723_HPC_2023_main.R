# CMEE 2022 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "yutao zhou"
preferred_name <- "leo"
email <- "lz723@imperial.ac.uk"
username <- "lz723"

# Please remember *not* to clear the workspace here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

# Question 1
species_richness <- function(community) {
  # Find unique species in the community
  unique_species <- unique(community)
  
  # Calculate the richness as the length of unique species
  richness <- length(unique_species)
  
  return(richness)
}


# Question 2
init_community_max <- function(size) {
  # Generate a sequence from 1 to size, each representing a unique species
  community <- seq(1, size)
  
  return(community)
}


# Question 3
init_community_min <- function(size) {
  # Create a vector where all elements are the same species, e.g., 1
  community <- rep(1, size)
  
  return(community)
}



# Question 4
choose_two <- function(max_value) {
  # Choose the first random integer
  first_choice <- sample(1:max_value, 1)
  
  # Generate a sequence excluding the first choice
  remaining_choices <- setdiff(1:max_value, first_choice)
  
  # Choose the second random integer from the remaining choices
  second_choice <- sample(remaining_choices, 1)
  
  return(c(first_choice, second_choice))
}



# Question 5
neutral_step <- function(community) {
  # Get the size of the community
  size <- length(community)
  
  # Use the choose_two function to pick two different individuals
  # The first will die, and the second will reproduce
  choices <- choose_two(size)
  
  # Replace the species of the dying individual with the species of the reproducing individual
  community[choices[1]] <- community[choices[2]]
  
  return(community)
}


# Question 6
neutral_generation <- function(community) {
  # Calculate the size of the community
  size <- length(community)
  
  # Determine the number of steps, rounding up or down randomly if size is odd
  num_steps <- ifelse(size %% 2 == 0, size / 2, floor(size / 2) + sample(c(0, 1), 1))
  
  # Perform neutral steps for one generation
  for (i in 1:num_steps) {
    community <- neutral_step(community)
  }
  
  return(community)
}

# Question 7
neutral_time_series <- function(community, duration) {
  # Initialize a vector to store species richness over time
  richness_series <- numeric(duration + 1)
  
  # Record the species richness of the initial community
  richness_series[1] <- species_richness(community)
  
  # Run the simulation for the specified duration
  for (i in 1:duration) {
    community <- neutral_generation(community)
    richness_series[i + 1] <- species_richness(community)
  }
  
  return(richness_series)
}

# Question 8
question_8 <- function() {
  # Generate initial community with maximal diversity
  initial_community <- init_community_max(100)
  
  # Run the simulation for 200 generations
  time_series <- neutral_time_series(initial_community, 200)
  
  # Plot the time series
  plot(time_series, type = "l", xlab = "Generation", ylab = "Species Richness",
       main = "Neutral Model Simulation over 200 Generations")
  
  # Save the plot
  png(filename="question_8", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 9
neutral_step_speciation <- function(community, speciation_rate) {
  # Get the size of the community
  size <- length(community)
  
  # Use the choose_two function to pick two different individuals
  choices <- choose_two(size)
  
  # Decide whether speciation occurs based on speciation_rate
  if (runif(1) < speciation_rate) {
    # Speciation: find a unique species number
    new_species <- max(community) + 1
    # Replace the dying individual with the new species
    community[choices[1]] <- new_species
  } else {
    # No speciation: replace the dying individual with the offspring of another
    community[choices[1]] <- community[choices[2]]
  }
  
  return(community)
}

# Question 10
neutral_generation_speciation <- function(community, speciation_rate) {
  # Calculate the size of the community
  size <- length(community)
  
  # Determine the number of steps, rounding up or down randomly if size is odd
  num_steps <- ifelse(size %% 2 == 0, size / 2, floor(size / 2) + sample(c(0, 1), 1))
  
  # Perform neutral steps with speciation for one generation
  for (i in 1:num_steps) {
    community <- neutral_step_speciation(community, speciation_rate)
  }
  
  return(community)
}

# Question 11
neutral_time_series_speciation <- function(community, duration, speciation_rate) {
  # Initialize a vector to store species richness over time
  richness_series <- numeric(duration + 1)
  
  # Record the species richness of the initial community
  richness_series[1] <- species_richness(community)
  
  # Run the simulation for the specified duration
  for (i in 1:duration) {
    community <- neutral_generation_speciation(community, speciation_rate)
    richness_series[i + 1] <- species_richness(community)
  }
  
  return(richness_series)
}

# Question 12
question_12 <- function() {
  # Parameters
  speciation_rate <- 0.1
  community_size <- 100
  duration <- 200
  
  # Initialize communities
  community_max <- init_community_max(community_size)
  community_min <- init_community_min(community_size)
  
  # Run simulations
  time_series_max <- neutral_time_series_speciation(community_max, duration, speciation_rate)
  time_series_min <- neutral_time_series_speciation(community_min, duration, speciation_rate)
  
  # Plot the time series
  plot(time_series_max, type = "l", col = "blue", xlab = "Generation", ylab = "Species Richness",
       main = "Neutral Model Simulation with Speciation over 200 Generations")
  lines(time_series_min, type = "l", col = "red")
  
  # Add a legend
  legend("topright", legend = c("Max Diversity", "Min Diversity"), col = c("blue", "red"), lty = 1)
  
  # Save the plot
  png(filename="question_12", width = 600, height = 400)
  # plot your graph here
  plot(time_series_max, type = "l", col = "blue", xlab = "Generation", ylab = "Species Richness",
       main = "Neutral Model Simulation with Speciation over 200 Generations")
  lines(time_series_min, type = "l", col = "red")
  legend("topright", legend = c("Max Diversity", "Min Diversity"), col = c("blue", "red"), lty = 1)
  dev.off()
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 13
species_abundance <- function(community) {
  # Count the occurrences of each species
  species_counts <- table(community)
  
  # Sort the counts in descending order
  sorted_counts <- sort(species_counts, decreasing = TRUE)
  
  return(sorted_counts)
}


# Question 14
octaves <- function(abundance) {
  # Determine the octave class for each abundance value
  # Adding 1 because log2(1) is 0, and we want species with abundance 1 to fall into the first octave
  octave_classes <- floor(log2(abundance) + 1)
  
  # Count the number of species in each octave class
  octave_counts <- tabulate(octave_classes, nbins = max(octave_classes))
  
  return(octave_counts)
}


# Question 15
sum_vect <- function(x, y) {
  # Make the lengths of both vectors equal by padding the shorter one with zeros
  length_diff <- abs(length(x) - length(y))
  if (length(x) > length(y)) {
    y <- c(y, rep(0, length_diff))
  } else {
    x <- c(x, rep(0, length_diff))
  }
  
  # Return the sum of the vectors
  return(x + y)
}



# Question 16 
question_16 <- function() {
  # Set up parameters
  initial_conditions <- list(init_community_max(100), init_community_min(100))
  final_octaves_min <- final_octaves_max <- numeric()
  burn_in <- 200
  total_generations <- 2000
  record_every <- 20
  
  # Burn-in period
  for (initial_condition in initial_conditions) {
    community <- initial_condition
    for (i in 1:burn_in) {
      community <- neutral_generation_speciation(community, 0.1)
    }
    
    # Record species abundance after burn-in
    for (i in 1:(total_generations/record_every)) {
      for (j in 1:record_every) {
        community <- neutral_generation_speciation(community, 0.1)
      }
      abundance <- species_abundance(community)
      octaves <- octaves(abundance)
      
      # Summing octave vectors
      if (identical(initial_condition, initial_conditions[[1]])) {
        final_octaves_max <- sum_vect(final_octaves_max, octaves)
      } else {
        final_octaves_min <- sum_vect(final_octaves_min, octaves)
      }
    }
  }
  
  # Calculate average octaves
  avg_octaves_max <- final_octaves_max / (total_generations/record_every)
  avg_octaves_min <- final_octaves_min / (total_generations/record_every)
  # Example plot data (replace this with your actual data)
 
  png(filename="question_16_min.png", width = 600, height = 400)
  barplot(avg_octaves_min, main="Species Abundance (Min Initial Condition)", xlab="Octave", ylab="Average Species Count")
  Sys.sleep(0.1)
  dev.off()
  
  # Plot for max initial condition
  png(filename="question_16_max.png", width = 600, height = 400)
  barplot(avg_octaves_max, main="Species Abundance (Max Initial Condition)", xlab="Octave", ylab="Average Species Count")
  Sys.sleep(0.1)
  dev.off()
  
  # Return your written answer
  return("type your written answer here")
}



# Question 17
neutral_cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name) {
  # starting community
  community <- init_community_min(size)
  
  # neutral generations for predefined amount of computing time
  start_time <- as.numeric(proc.time()[3]) / 60
  computing_time <- 0
  count <- 1
  time_series <- c(species_richness(community))
  abundance_list <- c(list(octaves(species_abundance(community))))
  
  while (computing_time <= wall_time){
    # current community
    community <- neutral_generation_speciation(community, 0.3) 
    
    # storing the species richness and abundances during burn-in
    if ((count <= burn_in_generations) && (count %% interval_rich == 0)){
      # species richness
      time_series <- c(time_series, species_richness(community))
    }
    # record species abundances every interval_oct generations
    if (count %% interval_oct == 0){
      abundance_list <- c(abundance_list, list(octaves(species_abundance(community))))
    }
    current_time <- as.numeric(proc.time()[3]) / 60
    computing_time <- current_time - start_time
    count <- count + 1
  }
  
  # total amount of time
  total_time <- current_time - start_time
  
  # Save the simulation results
  save(time_series, abundance_list, community, total_time, speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, file = output_file_name)
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on
# the cluster

# Question 20 
process_neutral_cluster_results <- function() {
  # Initialize counters for each cluster size
  cluster_500 <- 0
  cluster_1000 <- 0
  cluster_2500 <- 0
  cluster_5000 <- 0
  
  # Initialize vectors to store total abundance for each size
  total_500 <- c()
  total_1000 <- c()
  total_2500 <- c()
  total_5000 <- c()
  
  # Loop through each result file
  for (i in 1:100) {
    # Load simulation result
    load(file = paste0("Test_result", i, ".rda"))
    
    # Determine the community size based on file index
    if (i <= 25) {size = 500} 
    else if (i <= 50) {size = 1000} 
    else if (i <= 75) {size = 2500} 
    else {size = 5000}
    
    # Number of generations to exclude as burn-in
    burn_in = 80
    
    # Aggregate total abundance for each octave class
    total <- c()
    for (j in burn_in:length(abundance)) {
      total <- sum_vect(total, abundance[[j]])
    }
    
    # Update total and count for each community size
    assign(paste0("cluster_", size), get(paste0("cluster_", size)) + (length(abundance) - burn_in + 1))
    assign(paste0("total_", size), sum_vect(get(paste0("total_", size)), total))
  }
  
  # Calculate mean abundance for each community size
  mean_500 <- total_500 / cluster_500
  mean_1000 <- total_1000 / cluster_1000
  mean_2500 <- total_2500 / cluster_2500
  mean_5000 <- total_5000 / cluster_5000
  
  # Combine results into a list
  combined_results <- list(mean_500, mean_1000, mean_2500, mean_5000)
  
  # Save the combined results to an .rda file
  save(combined_results, file = "Combined_results.rda")
}


plot_neutral_cluster_results <- function() {
  # Load the processed results
  load("combined_results.rda")
  
  # Set up plotting parameters
  png(filename="plot_neutral_cluster_results.png", width = 600, height = 400)
  par(mfrow = c(2, 2))
  size_list <- c('500', '1000', '2500', '5000')
  
  # Create a bar plot for each community size
  for (i in 1:4) {
    data <- combined_results[[i]]
    max_height <- max(data) * 1.3
    barplot(data, 
            main = paste("Octave Class Distribution Size ", size_list[i]), 
            xlab = "Abundance Range with octave classes", 
            ylab = "Species Count",
            ylim = c(0, max_height))
  }
  
  dev.off()
  
  return(combined_results)
}



# Question 21
state_initialise_adult <- function(num_stages, initial_size) {
  # Create a state vector with zeros for all stages except the last one
  state <- rep(0, num_stages)
  
  # Place all individuals in the last life stage (adult stage)
  state[num_stages] <- initial_size
  
  return(state)
}


# Question 22
state_initialise_spread <- function(num_stages, initial_size) {
  # Calculate the base number of individuals per stage
  base_per_stage <- floor(initial_size / num_stages)
  
  # Create a state vector with the base number for each stage
  state <- rep(base_per_stage, num_stages)
  
  # Calculate the number of remaining individuals to distribute
  remaining <- initial_size %% num_stages
  
  # Distribute the remaining individuals starting from the youngest stage
  for (i in 1:remaining) {
    state[i] <- state[i] + 1
  }
  
  return(state)
}
#state_initialise_spread(num_stages=3, initial_size=8) 

# Question 23
deterministic_step <- function(state, projection_matrix) {
  # Perform matrix multiplication
  new_state <- projection_matrix %*% state
  
  # Convert the result to a vector
  new_state <- as.vector(new_state)
  
  return(new_state)
}


# Question 24
deterministic_simulation <- function(initial_state, projection_matrix, simulation_length) {
  # Initialize the population size vector
  population_size <- numeric(simulation_length + 1)
  population_size[1] <- sum(initial_state)
  
  # Current state of the population
  current_state <- initial_state
  
  # Apply the deterministic model for each time step
  for (step in 1:simulation_length) {
    # Update the state using the deterministic step
    current_state <- deterministic_step(current_state, projection_matrix)
    
    # Update the total population size for this time step
    population_size[step + 1] <- sum(current_state)
  }
  
  return(population_size)
}

# Question 25
question_25 <- function() {
  # Define the projection matrix
  growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                            0.5, 0.4, 0.0, 0.0,
                            0.0, 0.4, 0.7, 0.0,
                            0.0, 0.0, 0.25, 0.4),
                          nrow=4, ncol=4, byrow=TRUE)
  reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0),
                                nrow=4, ncol=4, byrow=TRUE)
  projection_matrix <- reproduction_matrix + growth_matrix
  
  # Initial conditions
  initial_condition_adults <- c(0, 0, 0, 100)
  initial_condition_spread <- c(25, 25, 25, 25)
  
  # Run simulations
  simulation_length <- 24
  population_adults <- deterministic_simulation(initial_condition_adults, projection_matrix, simulation_length)
  population_spread <- deterministic_simulation(initial_condition_spread, projection_matrix, simulation_length)
  
  # Plotting
  png(filename="question_25.png", width=600, height=400)
  plot(population_adults, type="o", col="blue", xlab="Time Step", ylab="Population Size", main="Population Size Time Series")
  lines(population_spread, type="o", col="red")
  legend("topright", legend=c("Adults Only", "Evenly Spread"), col=c("blue", "red"), lty=1)
  dev.off()
  
  # Written answer
  return("The initial distribution of the population among different life stages significantly impacts both the initial and eventual population growth. A population starting primarily in the adult stage will have a slower initial growth due to lower reproduction rates but may achieve stability sooner. In contrast, a population evenly spread across all stages can utilize the higher reproductive potential of younger stages, potentially leading to a faster initial growth rate but may take longer to stabilize.")
}

# Question 26
multinomial <- function(pool, probs) {
  # Check if the sum of probabilities is less than 1
  if (sum(probs) < 1) {
    # Add the implicit death event
    probs <- c(probs, 1 - sum(probs))
  }
  
  # Generate one sample from the multinomial distribution
  result <- rmultinom(n = 1, size = pool, prob = probs)
  
  # Return the result as a vector
  return(colSums(result))
}


# Question 27
survival_maturation <- function(state, growth_matrix) {
  # 1. Initialize new_state with zeros
  new_state <- rep(0, length(state))
  
  # 2. Process each life stage
  for (i in 1:length(state)) {
    # a. Number of individuals in current stage
    num_individuals <- state[i]
    
    # b. Probabilities for staying or moving to the next stage
    probs <- growth_matrix[i, ]
    
    # c. Apply multinomial to get transitions
    transitions <- multinomial(num_individuals, probs)
    
    # d. Add transitions to new_state
    for (j in 1:length(transitions)) {
      if (j <= length(new_state)) {
        new_state[j] <- new_state[j] + transitions[j]
      }
    }
  }
  
  # 3. Return the new_state
  return(new_state)
}


# Question 28
random_draw <- function(probability_distribution) {
  # Create a vector of values corresponding to the indices of probability_distribution
  values <- seq(along = probability_distribution)
  
  # Use the sample function to draw one value based on the given probabilities
  drawn_value <- sample(values, size = 1, prob = probability_distribution, replace = TRUE)
  
  return(drawn_value)
}

# Question 29
stochastic_recruitment <- function(reproduction_matrix, clutch_distribution) {
  # Extract the recruitment rate from the reproduction matrix (top-right element)
  recruitment_rate <- reproduction_matrix[1, ncol(reproduction_matrix)]
  
  # Calculate the expected clutch size
  values <- seq(along = clutch_distribution)
  expected_clutch_size <- sum(values * clutch_distribution)
  
  # Calculate the recruitment probability
  recruitment_probability <- recruitment_rate / expected_clutch_size
  
  # Check for inconsistencies in the model parameters
  if (recruitment_probability > 1) {
    stop("Inconsistency in model parameters: recruitment probability exceeds 1.")
  }
  
  return(recruitment_probability)
}

# Question 30
offspring_calc <- function(state, clutch_distribution, recruitment_probability) {
  # Identify the number of adults in the state
  num_adults <- state[length(state)]  # Assuming adults are the last in the state vector
  
  # Generate the number of adults which recruit
  num_recruits <- rbinom(1, num_adults, recruitment_probability)
  
  # Initialize total offspring count
  total_offspring <- 0
  
  # Calculate total offspring from each clutch
  for (i in 1:num_recruits) {
    clutch_size <- random_draw(clutch_distribution)
    total_offspring <- total_offspring + clutch_size
  }
  
  # Ensure total_offspring is 0 if number of clutches is 0
  if (num_recruits == 0) {
    total_offspring <- 0
  }
  
  return(total_offspring)
}


# Question 31
stochastic_step <- function(state, growth_matrix, reproduction_matrix, clutch_distribution, recruitment_probability) {
  # Apply survival and maturation to generate new state
  new_state <- survival_maturation(state, growth_matrix)
  
  # Compute the number of offspring
  total_offspring <- offspring_calc(state, clutch_distribution, recruitment_probability)
  
  # Add offspring to the first life stage of new_state
  new_state[1] <- new_state[1] + total_offspring
  
  return(new_state)
}


# Question 32
stochastic_simulation <- function(initial_state, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length) {
  # Calculate individual recruitment probability
  recruitment_probability <- stochastic_recruitment(reproduction_matrix, clutch_distribution)
  
  # Initialize the population size vector
  population_size <- numeric(simulation_length + 1)
  population_size[1] <- sum(initial_state)
  
  # Current state of the population
  current_state <- initial_state
  
  # Apply the stochastic model for each time step
  for (step in 1:simulation_length) {
    # Check if population has gone extinct
    if (sum(current_state) == 0) {
      # Fill the remaining entries with 0s and break the loop
      population_size[(step+1):(simulation_length+1)] <- 0
      break
    }
    
    # Update the state using stochastic step
    current_state <- stochastic_step(current_state, growth_matrix, reproduction_matrix, clutch_distribution, recruitment_probability)
    
    # Update the total population size for this time step
    population_size[step + 1] <- sum(current_state)
  }
  
  return(population_size)
}

# Question 33
question_33 <- function() {
  # Define the projection matrix as in Question 25
  growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                            0.5, 0.4, 0.0, 0.0,
                            0.0, 0.4, 0.7, 0.0,
                            0.0, 0.0, 0.25, 0.4),
                          nrow=4, ncol=4, byrow=TRUE)
  reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0),
                                nrow=4, ncol=4, byrow=TRUE)
  projection_matrix <- reproduction_matrix + growth_matrix
  
  # Clutch distribution
  clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)
  
  # Initial conditions
  initial_condition_adults <- c(0, 0, 0, 100)
  initial_condition_spread <- c(25, 25, 25, 25)
  
  # Run stochastic simulations
  simulation_length <- 24
  population_adults_stochastic <- stochastic_simulation(initial_condition_adults, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length)
  population_spread_stochastic <- stochastic_simulation(initial_condition_spread, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length)
  
  # Plotting
  png(filename="question_33.png", width=600, height=400)
  plot(population_adults_stochastic, type="o", col="blue", xlab="Time Step", ylab="Population Size", main="Stochastic Population Size Time Series")
  lines(population_spread_stochastic, type="o", col="red")
  legend("topright", legend=c("Adults Only", "Evenly Spread"), col=c("blue", "red"), lty=1)
  dev.off()
  
  # Written answer
  return("The stochastic simulations display more variability and less predictability compared to the smooth curves of deterministic simulations. This variability arises from the inherent randomness in the stochastic model, where each event (like survival, maturation, or reproduction) is influenced by probability distributions, leading to different outcomes in each run of the simulation.")
}


# Questions 34 and 35 involve writing code elsewhere to run your simulations on the cluster

# Question 36
question_36 <- function(){
  # Initialize a vector to store the number of extinctions for each of the four initial conditions
  extinct_counts <- rep(0, 4)
  
  # Loop through each simulation file
  for(i in 1:100){
    # Determine the initial condition based on the simulation file index
    if(i <= 25) condition = 1
    else if(i <= 50) condition = 2
    else if(i <= 75) condition = 3
    else if(i <= 100) condition = 4
    
    # Construct the file path for the current simulation result
    datapath = paste("stochastic_", i, ".rda", sep="")
    load(datapath)
    
    # Loop through each of the 150 simulations in the file
    for(j in 1:150){
      a <- simu_results[j]
      # Get the final population size of the simulation
      final_num <- a[[1]][length(a[[1]])]
      
      # Increment the extinction count if the final population size is 0
      if(final_num == 0){
        extinct_counts[condition] <- extinct_counts[condition] + 1
      }
    }
  }
  
  # Calculate the extinction rate for each initial condition
  extinct_rate <- extinct_counts / rep(25 * 150, 4)
  print(extinct_counts)
  print(extinct_rate)
  
  # Label the extinction rates with descriptive names of initial conditions
  names(extinct_rate) = c("Large 100 adults", "Small 10 adults", "Large 100 spread", "Small 10 spread")
  
  # Plotting the extinction rates
  png(filename="question_36.png", width = 600, height = 400)
  barplot(extinct_rate,
          xlab = "Initial Conditions", ylab = "Proportion of Extinction", ylim = c(0, max(extinct_rate) + 0.01),
          main = "Extinction Rate")
  Sys.sleep(0.1)
  dev.off()
  
  # Return a written analysis of which population was most likely to go extinct and why
  return("Populations with initial conditions of a small population of 10 individuals spread across the life stages are most likely to become extinct, followed by
   a small population of 10 adults. Smaller populations are more vulnerable to extinction due to random fluctuations, as they have a lower capacity to buffer against demographic and environmental stochasticity. Additionally, populations spread across life stages have fewer individuals in the reproductive stage, reducing their resilience to population decline. However, it's important to note that the risk of extinction is not confined to just these groups. In stochastic models, all populations, regardless of their initial size or distribution across life stages, are subject to the possibility of extinction. This risk is inherent in the stochastic nature of population dynamics, where random events can lead to the demise of even larger, seemingly stable groups ")
}



# Question 37
question_37 <- function() {
  # Define lengths for time series data
  num_steps <- 121
  num_simulations <- 25 * 150  # Total number of simulations for each condition
  
  # Initialize vectors to accumulate population sizes across simulations
  total_100_spread <- rep(0, num_steps)
  total_10_spread <- rep(0, num_steps)
  
  # Accumulate population sizes from stochastic simulations
  for (i in 51:100) { 
    file_name <- paste("stochastic_", i, ".rda", sep="")
    load(file_name)
    for (t in 1:150) {
      if (i <= 75) {
        # Accumulate for large spread (100 individuals)
        total_100_spread <- total_100_spread + simu_results[t][[1]]
      } else {
        # Accumulate for small spread (10 individuals)
        total_10_spread <- total_10_spread + simu_results[t][[1]]
      }
    }
  }
  
  # Calculate mean population size at each time step for both conditions
  mean_100_spread <- total_100_spread / num_simulations
  mean_10_spread <- total_10_spread / num_simulations
  
  # Define projection matrix for deterministic simulations
  growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                            0.5, 0.4, 0.0, 0.0,
                            0.0, 0.4, 0.7, 0.0,
                            0.0, 0.0, 0.25, 0.4), nrow=4, byrow=TRUE)
  reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0), nrow=4, byrow=TRUE)
  projection_matrix <- reproduction_matrix + growth_matrix
  
  # Run deterministic simulations for both initial conditions
  deterministic_large <- deterministic_simulation(state_initialise_spread(4, 100), projection_matrix, 120)
  deterministic_small <- deterministic_simulation(state_initialise_spread(4, 10), projection_matrix, 120)
  
  # Calculate deviation of stochastic model from deterministic model
  spread_10_deviation <- mean_10_spread / deterministic_small
  spread_100_deviation <- mean_100_spread / deterministic_large
  
  # Plot the deviations
  png(filename="question_37.png", width = 600, height = 400)
  plot(1:num_steps, spread_10_deviation, type = "l", col = "blue", 
       ylim = c(min(spread_10_deviation, spread_100_deviation) - 0.01, 
                max(spread_10_deviation, spread_100_deviation) + 0.01),
       main = "Deviation of Stochastic Model from Deterministic Model", 
       xlab = "Time Steps", ylab = "Deviation")
  lines(1:num_steps, spread_100_deviation, type = "l", col = "black")
  abline(h=1, lty=2, col="red")
  legend("topright", 
         legend=c("Initial 10 population spread", "Initial 100 population spread"), 
         col=c("blue", "black"), lty=1)
  dev.off()
  
  # Return an explanation of which initial condition better approximates average behavior
  return("For an initial condition of 100 individuals spread across the life stages, it is more appropriate to approximate the ‘average’ behavior of this stochastic system with a deterministic model. This is because random fluctuations have a smaller relative impact on a larger population, thus averaging out the effects of randomness and making the deterministic model a better predictor of average population behavior.")
}




# Challenge questions - these are optional, substantially harder, and a maximum
# of 14% is available for doing them. 

# Challenge question A
run_neutral_simulation_max <- function(num_generations) {
  community_size <- 100  # Assuming a community size of 100 individuals
  speciation_rate <- 0.1  # Example speciation rate
  
  # Initialize community with maximal diversity
  community <- init_community_max(community_size)
  
  # Vector to store species richness at each generation
  richness_values <- numeric(num_generations)
  
  # Run the simulation
  for (generation in 1:num_generations) {
    community <- neutral_generation_speciation(community, speciation_rate)
    richness_values[generation] <- species_richness(community)
  }
  
  return(richness_values)
}
run_neutral_simulation_min <- function(num_generations) {
  community_size <- 100  # Assuming a community size of 100 individuals
  speciation_rate <- 0.1  # Example speciation rate
  
  # Initialize community with minimal diversity
  community <- init_community_min(community_size)
  
  # Vector to store species richness at each generation
  richness_values <- numeric(num_generations)
  
  # Run the simulation
  for (generation in 1:num_generations) {
    community <- neutral_generation_speciation(community, speciation_rate)
    richness_values[generation] <- species_richness(community)
  }
  
  return(richness_values)
}

calculate_ci <- function(data) {
  num_simulations <- ncol(data)
  means <- apply(data, 1, mean)
  sds <- apply(data, 1, sd)
  sem <- sds / sqrt(num_simulations)
  ci_multiplier <- qnorm(1 - (1 - 0.972) / 2)
  ci <- sem * ci_multiplier
  cbind(lower = means - ci, upper = means + ci)
}
Challenge_A <- function() {
  # Define parameters
  num_simulations <- 100  # Example number of simulations
  num_generations <- 200  # Example number of generations
  
  # Initialize matrices to store species richness data
  richness_data_max <- matrix(nrow = num_generations, ncol = num_simulations)
  richness_data_min <- matrix(nrow = num_generations, ncol = num_simulations)
  
  # Run simulations for both initial conditions
  for (i in 1:num_simulations) {
    richness_data_max[, i] <- run_neutral_simulation_max(num_generations)
    richness_data_min[, i] <- run_neutral_simulation_min(num_generations)
  }
  
  # Calculate mean and confidence intervals for each generation
  mean_max <- apply(richness_data_max, 1, mean)
  mean_min <- apply(richness_data_min, 1, mean)
  ci_max <- calculate_ci(richness_data_max)
  ci_min <- calculate_ci(richness_data_min)
  
  
  
  # Plotting and saving the graph
  plot(1:num_generations, mean_max, type = 'l', col = 'blue', ylim = range(c(ci_max, ci_min)), xlab = "Generations", ylab = "Species Richness")
  lines(1:num_generations, mean_min, col = 'red')
  polygon(c(1:num_generations, rev(1:num_generations)), c(ci_max[,1], rev(ci_max[,2])), col = rgb(0, 0, 1, 0.1), border = NA)
  polygon(c(1:num_generations, rev(1:num_generations)), c(ci_min[,1], rev(ci_min[,2])), col = rgb(1, 0, 0, 0.1), border = NA)
  legend("topright", legend = c("Max Initial Richness", "Min Initial Richness"), col = c("blue", "red"), lty = 1)
  
  # Save plot
  png("Challenge_A.png")
  plot(1:num_generations, mean_max, type = 'l', col = 'blue', ylim = range(c(ci_max, ci_min)), xlab = "Generations", ylab = "Species Richness")
  lines(1:num_generations, mean_min, col = 'red')
  polygon(c(1:num_generations, rev(1:num_generations)), c(ci_max[,1], rev(ci_max[,2])), col = rgb(0, 0, 1, 0.1), border = NA)
  polygon(c(1:num_generations, rev(1:num_generations)), c(ci_min[,1], rev(ci_min[,2])), col = rgb(1, 0, 0, 0.1), border = NA)
  legend("topright", legend = c("Max Initial Richness", "Min Initial Richness"), col = c("blue", "red"), lty = 1)
  dev.off()
  
  # Estimate dynamic equilibrium (this would need a specific implementation)
  equilibrium_estimate <- estimate_equilibrium(mean_max, mean_min)
  
  # Return equilibrium estimate
  return(paste("The system is estimated to reach dynamic equilibrium after", equilibrium_estimate, "generations."))
}
estimate_equilibrium <- function(mean_max, mean_min) {
  # Threshold for considering the system to be in equilibrium
  threshold <- 0.1  # Example value, adjust based on your data
  
  # Number of consecutive generations to confirm equilibrium
  confirm_generations <- 10  # Example value
  
  # Function to estimate equilibrium point for a given data set
  find_equilibrium_point <- function(data) {
    count <- 0
    for (i in 2:length(data)) {
      if (abs(data[i] - data[i - 1]) < threshold) {
        count <- count + 1
        if (count >= confirm_generations) {
          return(i - confirm_generations)
        }
      } else {
        count <- 0
      }
    }
    return(NA)  # Return NA if equilibrium is not found
  }
  
  # Estimate equilibrium points for both data sets
  equilibrium_max <- find_equilibrium_point(mean_max)
  equilibrium_min <- find_equilibrium_point(mean_min)
  
  # Return the average of the two equilibrium points
  return(mean(c(equilibrium_max, equilibrium_min), na.rm = TRUE))
}
#Challenge B
Challenge_B <- function() {
  # Define parameters for the simulation
  num_generations <- 200  # Number of generations for each simulation
  num_simulations <- 50   # Number of simulations for each initial richness
  speciation_rate <- 0.1  # Example speciation rate
  community_size <- 100   # Community size
  
  # Range of initial species richness levels
  richness_levels <- 1:community_size  
  
  # Data structure to store time series for each initial richness
  time_series_data <- list()
  
  for (richness_level in richness_levels) {
    # Initialize matrix to store species richness data for each simulation
    richness_data <- matrix(nrow = num_generations, ncol = num_simulations)
    
    for (i in 1:num_simulations) {
      # Initialize community for the current richness level
      community <- sample(richness_level, community_size, replace = TRUE)
      
      for (generation in 1:num_generations) {
        community <- neutral_generation_speciation(community, speciation_rate)
        richness_data[generation, i] <- species_richness(community)
      }
    }
    
    # Average the species richness data across all simulations for the current richness level
    time_series_data[[richness_level]] <- colMeans(richness_data)
  }
  
  # Plot the averaged time series for each initial richness level
  plot_time_series(time_series_data)
  
  # Save the plot
  png("Challenge_B.png")
  plot_time_series(time_series_data)
  dev.off()
}

# Challenge question C
Challenge_C <- function() {
  
  
  
  png(filename="Challenge_C", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()

}

# Challenge question D
Challenge_D <- function() {
  
  
  
  png(filename="Challenge_D", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function(){
  
  
  
  png(filename="Challenge_E", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Challenge question F
Challenge_F <- function(){
  
  
  
  png(filename="Challenge_F", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
}
