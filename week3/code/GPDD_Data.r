# Install the maps package if it's not already installed
if (!require(maps)) {
  install.packages("maps")
  library(maps)
}

# Load the GPDD data
# Assuming the GPDDFiltered.RData file is in the current working directory
load("../data/GPDDFiltered.RData")

# Examine the data to understand its structure
# Usually, you would use head(), str(), or summary() functions to see the data
# head(GPDDFiltered)
# str(GPDDFiltered)
# summary(GPDDFiltered)

# Assuming GPDDFiltered has latitude and longitude columns
# Now, create a world map
world_map <- map("world", fill=TRUE, col="#F0F0F0", bg="white", lwd=0.05)

# Superimpose the locations from the GPDD data
# Assuming the data frame GPDDFiltered has 'Latitude' and 'Longitude' columns
points(gpdd$Long, gpdd$Lat, col="blue", pch=20, cex=1)

# Save the plot if needed
# dev.copy(png, 'GPDD_Map.png')
# dev.off()

# Potential biases comment
# Based on the locations plotted, we might expect spatial biases in the data. For instance,
# there may be a greater number of data points from North America and Europe, where
# scientific research and data collection efforts are historically more intensive. This
# could lead to underrepresentation of data from Africa, Asia, and South America. There may
# also be biases toward accessible areas or regions where certain species of interest are
# located. These biases could affect the generalizability of any analysis conducted on this
# dataset, making it less applicable to areas or species underrepresented in the data.
