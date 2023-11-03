library(tidyverse)

# Assuming 'MyData' is already loaded as in your previous script

MyData <- read_csv("../data/PoundHillData.csv", col_names = FALSE) %>% 
  as_tibble()  # Converts to a tibble, which is a modern version of a data frame

# To replace empty cells with zeros as in your previous script
MyData <- MyData %>% 
  mutate(across(everything(), ~ifelse(.x == "", 0, .x)))  # Replaces empty strings with 0

# To transpose data
# Transposition is not a typical tidyverse operation, it may be better to keep it as is from your previous script.

MyData <- as_tibble(t(MyData))

# Assigning column names from the first row and then removing it
colnames(MyData) <- MyData[1, ]
MyData <- MyData[-1, ]

# Converting from wide to long format using pivot_longer() from tidyr instead of melt()
MyDataLong <- MyData %>%
  pivot_longer(
    cols = -c(Cultivation, Block, Plot, Quadrat),  # Assuming these are the ID columns
    names_to = "Species",
    values_to = "Count"
  )

MyDataLong <- MyDataLong %>%
  mutate(
    Across(c(Cultivation, Block, Plot, Quadrat), as.factor),
    Count = as.integer(Count)
  )

#Inspect the data
glimpse(MyDataLong)
print(head(MyDataLong))

# Continue with your exploratory data analysis...


write_csv(MyDataLong, "../results/MyWrangledData.csv")
