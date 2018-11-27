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
vec_packages <- c("readr", "magrittr", "tibble", "tidyr" , "dplyr")
pacman::p_load(char = vec_packages, install = TRUE)

# Data Import -------------------------------------------------------------
data_survey <- read_csv(file = "data/SurveyResponses2018.csv")

# Data Clean --------------------------------------------------------------
data_survey <- data_survey %>% 
  as.tibble() %>% 
  # pad out tibble with previous row's entries
  fill(x = c("UserID", "Film", "Question")) %>% 
  # convert funny dates into ranges to replicate what's shown in the survey.
  # Seems to be something funny when converting Excel to csv since '1-3' turns to '01-Mar'
  mutate(Choice = case_when(
    Choice == "01-Mar"    ~ "1-3",
    Choice == "04-Jul"    ~ "4-7",
    Choice == "Aug-13"    ~ "8-13",
    TRUE                  ~ Choice
  )) %>% 
  # replace NA with 0 to mean they did not answer these sections
  mutate(Response = ifelse(is.na(Response), 0, Response),
         Film = as.factor(x = Film),
         Question = as.factor(x = Question),
         Choice = as.factor(x = Choice))

# Interpretation-specific cleaning
# DESC: Cleaning dataframe where we had to make some interpretations 
#       when translating the 2017 version of the survey responses to 2018
data_survey <- data_survey %>% 
  mutate(Choice = str_replace_all(string = Choice, 
                              pattern = "The director\\(s\\)", 
                              replacement = "The director(s) and/or actor(s)"))
