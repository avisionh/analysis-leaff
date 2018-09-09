# ------------------ #
# 0.2 - functionTest #
# ------------------ #

# ------------------------------------------
# DESC: creates unit tests to ensure functions are working
# SCRIPT DEPENDENCIES: none
# PACKAGE DEPENDENCIES:
# 1. 'pacman'
# 2. 'magrittr'
# 3. 'dplyr'
# 4. 'tibble'

# NOTES: none
# ------------------------------------------
vec_pacakges <- c("pacman", "magrittr", "dplyr", "ggplot2", "scales")
pacman::p_load(char = vec_packages, install = TRUE)

# UNIT TEST 1: [Field] = "Age"
# For those who responded since those who didn't, will need to think of a smarter matching/joining method
# such that we don't end up adding all 'prefer not to say/did not answer'
x <- data_demographics_master %>% 
  filter(Category == "Age" & Field != "prefer not to say / did not answer") %>% 
  select(Field) %>% 
  pull()
ggplot(data = data.frame(x), mapping = aes(x = x)) +
  geom_bar(mapping = aes(y = (..count..)), stat = "count", fill = "seagreen2") +
  geom_text(mapping = aes(y = (..count..),
                          label = ifelse((..count..) == 0, "",
                                         scales::percent((..count..)/sum(..count..)))), 
            stat="count", 
            colour = "black")

# UNIT TEST 2: [Category] = "Rating of experience"
data <- filter(.data = data_demographics, Category == "Rating of the experience")
data <- data %>% 
  mutate(Percent = round(x = Value/sum(Value), digits = 2))
func_plot_pie(x = data, col_counts = "Percent", col_category = "Field",
              plot_title = "Rating", factor_levels = c("Brilliant       *****", "****", "***", "**", "Poor *"))