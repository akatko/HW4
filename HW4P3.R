# Load necessary libraries
library(MASS)
library(ggplot2)
library(gridExtra)

# Get the Cars93 dataset
cars93 <- MASS::Cars93

# Create the plot with linear model
p_lm <- ggplot(cars93, aes(x = Price, y = Fuel.tank.capacity)) +
  geom_point(color = "grey60") +
  geom_smooth(se = TRUE, method = "lm", color = "#8fe388") +
  scale_x_continuous(
    name = "price (USD)",
    breaks = c(20, 40, 60),
    labels = c("$20,000", "$40,000", "$60,000")
  ) +
  scale_y_continuous(name = "fuel-tank capacity\n(US gallons)") +
  ggtitle("Linear Model (lm)") +
  theme(plot.title = element_text(size = 14, color = "#8fe388"))

# Create the plot with generalized linear model
p_glm <- ggplot(cars93, aes(x = Price, y = Fuel.tank.capacity)) +
  geom_point(color = "grey60") +
  geom_smooth(se = TRUE, method = "glm", color = "#fe8d6d") +
  scale_x_continuous(
    name = "price (USD)",
    breaks = c(20, 40, 60),
    labels = c("$20,000", "$40,000", "$60,000")
  ) +
  scale_y_continuous(name = "fuel-tank capacity\n(US gallons)") +
  ggtitle("Generalized Linear Model (glm)") +
  theme(plot.title = element_text(size = 14, color = "#fe8d6d"))

# Create the plot with generalized additive model
p_gam <- ggplot(cars93, aes(x = Price, y = Fuel.tank.capacity)) +
  geom_point(color = "grey60") +
  geom_smooth(se = TRUE, method = "gam", formula = y ~ s(x), color = "#7c6bea") +
  scale_x_continuous(
    name = "price (USD)",
    breaks = c(20, 40, 60),
    labels = c("$20,000", "$40,000", "$60,000")
  ) +
  scale_y_continuous(name = "fuel-tank capacity\n(US gallons)") +
  ggtitle("Generalized Additive Model (gam)") +
  theme(plot.title = element_text(size = 14, color = "#7c6bea"))

# Arrange the plots in a grid
grid.arrange(p_lm, p_glm, p_gam, ncol = 1)

