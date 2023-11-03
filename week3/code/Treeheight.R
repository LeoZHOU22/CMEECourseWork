# Load required libraries
install.packages("readr", quiet = TRUE)
library(readr)

# Load the trees.csv data
trees_data <- read_csv("/home/leo/Documents/CMEECourseWork/week3/data/trees.csv")

# Calculate tree height using trigonometry
# Note: The angle needs to be converted from degrees to radians
trees_data$Tree.Height.m <- trees_data$Distance.m * tan(trees_data$Angle.degrees * pi / 180)

# Write the data to a new csv file in the "results" directory
if (!dir.exists("results")) {
  dir.create("results")
}
write_csv(trees_data, "/home/leo/Documents/CMEECourseWork/week3/results/TreeHts.csv")
