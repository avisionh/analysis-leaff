# --------------- #
# 0 - dataWrangle #
# --------------- #

# ------------------------------------------
# DESC: wanrgles data into suitable format for analysis
# SCRIPT DEPENDENCIES: none
# PACKAGE DEPENDENCIES:
# 1. 'pacman'
# 2. 'magrittr'
# 3. 'dplyr'
# 4. 'tibble'

# NOTES: none
# ------------------------------------------

# Data import and wrangling
vec_packages <- c("magrittr", "dplyr", "tibble")
pacman::p_load(char = vec_packages, install = TRUE)

# Data: Demographics ------------------------------------------------------

# Stage 1. Replace NAs so we can reformat our data by using the 'rep' function 
temp_data <- data_demographics %>% 
  mutate_at(.vars = vars(Value), .funs = funs(replace(., is.na(.), 0)))

# Stage 2. Replicate our values to plot both counts and percentages
data_demographics_master <- rep(x = temp_data$Field, times = temp_data$Value)

# Stage 3. Join in 'Field' category so we can do filtering in plots
data_demographics_master <- data_demographics_master %>% 
  as.tibble() %>% 
  left_join(y = data_demographics, by = c("value" = "Field")) %>% 
  rename(Field = value) %>% 
  select(Category, Field) %>% 
  filter(Field != "prefer not to say / did not answer")


# Data: Activity Fund -----------------------------------------------------
data_activity_fund_master <- rep(x = data_activity_fund$FilmTitle, times = data_activity_fund$TotalAdmissions)

data_activity_fund_master <- data_activity_fund_master %>% 
  as.tibble() %>% 
  left_join(y = data_activity_fund, by = c("value" = "FilmTitle")) %>% 
  rename(FilmTitle = value) %>% 
  select(FilmTitle, VenueName)


rm(temp_data)
