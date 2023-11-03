library(tidyverse)


# Read the dataset from the Data directory
df <- read_csv("../data/EcolArchives-E089-51-D1.csv")

# Calculate the log of masses and size ratio
df <- df %>%
  mutate(
    log_predator_mass = log(Predator.mass),
    log_prey_mass = log(Prey.mass),
    log_size_ratio = log(Prey.mass / Predator.mass)
  )

# Function to create subplots for each feeding interaction type
create_density_plots <- function(data, variable, file_name) {
  p <- ggplot(data, aes_string(x = variable, fill = "Type.of.feeding.interaction")) +
    geom_density(alpha = 0.7) +
    facet_wrap(~Type.of.feeding.interaction, scales = "free") +
    theme_minimal() +
    labs(x = paste("Log of", variable), y = "Density") +
    theme(legend.position = "none")
  
  ggsave(file.path("../results", file_name), p, width = 14, height = 8)
}

# Create and save density plots for each variable
create_density_plots(df, 'log_predator_mass', 'Pred_Density_Subplots.pdf')
create_density_plots(df, 'log_prey_mass', 'Prey_Density_Subplots.pdf')
create_density_plots(df, 'log_size_ratio', 'SizeRatio_Density_Subplots.pdf')

# Part 3: Calculate Statistics
# Calculating log mean and median for predator mass, prey mass, and size ratio by feeding type
results <- df %>%
  group_by(Type.of.feeding.interaction) %>%
  summarise(
    mean_log_predator_mass = mean(log_predator_mass, na.rm = TRUE),
    median_log_predator_mass = median(log_predator_mass, na.rm = TRUE),
    mean_log_prey_mass = mean(log_prey_mass, na.rm = TRUE),
    median_log_prey_mass = median(log_prey_mass, na.rm = TRUE),
    mean_log_size_ratio = mean(log_size_ratio, na.rm = TRUE),
    median_log_size_ratio = median(log_size_ratio, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = -Type.of.feeding.interaction, names_to = "Statistic", values_to = "Value")

# Save the statistics to a CSV file in the Data directory
write_csv(results, "../results/PP_Results.csv")
