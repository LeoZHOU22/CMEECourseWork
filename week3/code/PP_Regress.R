library(ggplot2)
library(dplyr)

# Set the path to the dataset and read it
df <- read.csv("../data/EcolArchives-E089-51-D1.csv", header = TRUE, sep = ",", stringsAsFactors = TRUE)
# Save regression results to a dataframe and then to CSV
regression_results <- df %>%
  group_by(Type.of.feeding.interaction, Predator.lifestage) %>%
  do(model = lm(Prey.mass ~ Predator.mass, data = .)) %>%
  summarize(
    slope = coef(model)[[2]],
    intercept = coef(model)[[1]],
    R = summary(model)$r.squared,
    F_statistic = summary(model)$fstatistic[1],
    p_value = summary(model)$fstatistic[2]
  )

write.csv(regression_results, "../results/PP_Regress_Results.csv", row.names = TRUE)

 # Save plot as a PDF in the Results directory
par(mfcol=c(5,1))
ggplot(df, aes(x = log(Predator.mass), y = log(Prey.mass),color = Predator.lifestage, shape = Predator.lifestage)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, aes(fill = Predator.lifestage)) +
  facet_wrap(.~Type.of.feeding.interaction, ncol = 1) +
  labs(title = "Predator vs Prey Mass by Feeding Type",
        x = "Prey Mass in grams",
        y = "Predator Mass in grams") +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "white"))
ggsave("../results/PP_Regress_plot.pdf", device = "pdf")
