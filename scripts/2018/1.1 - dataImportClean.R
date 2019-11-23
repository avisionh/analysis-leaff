# --------------------- #
# 0 - dataImportClean #
# --------------------- #

# ------------------------------------------
# DESC: loads, and cleans Excel data into suitable format for analysis
# SCRIPT DEPENDENCIES: none
# PACKAGE DEPENDENCIES:
 # 1. 'pacman' 
 # 2. 'readxl'
 # 3. 'magrittr'
 # 4. 'janitor'
 # 5. 'dplyr'
 # 6. 'tidyr'

# NOTES: none
# ------------------------------------------

# Data import and wrangling
vec_packages <- c("readr", "magrittr", "tibble", "tidyr" , "dplyr", "stringr")
pacman::p_load(char = vec_packages, install = TRUE)

year_latest <- 2019

# Data Import -------------------------------------------------------------
data_survey <- read_csv(file = "data/data_survey.csv")

# Data Clean --------------------------------------------------------------
data_survey <- data_survey %>% 
  as_tibble() %>% 
  # pad out tibble with previous row's entries
  fill(x = c("UserID", "Film", "Question")) %>% 
  # convert funny dates into ranges to replicate what's shown in the survey.
  # Seems to be something funny when converting Excel to csv since '1-3' turns to '01-Mar'
  mutate(Selection = case_when(
    Selection == "01-Mar"    ~ "1-3",
    Selection == "04-Jul"    ~ "4-7",
    Selection == "Aug-13"    ~ "8-13",
    TRUE                  ~ Selection
  )) %>% 
  # replace NA with 0 to mean they did not answer these sections
  mutate(Response = ifelse(is.na(Response), 0, Response),
         Film = as.factor(x = Film),
         Question = as.factor(x = Question),
         Selection = as.factor(x = Selection))


# Interpretation-specific cleaning
# DESC: Cleaning dataframe where we had to make some interpretations 
#       when translating the 2017 version of the survey responses to 2018
data_survey <- data_survey %>% 
  mutate(Selection = str_replace_all(string = Selection, 
                                  pattern = "The director\\(s\\)", 
                                  replacement = "The director(s) and/or actor(s)"))

# filter for latest year
data_survey <- filter(.data = data_survey, YearOfFestival == year_latest)