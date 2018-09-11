# --------------------- #
# 0 - dataImportWrangle #
# --------------------- #

# ------------------------------------------
# DESC: loads, and cleans Excel data into suitable format for analysis
# SCRIPT DEPENDENCIES: none
# PACKAGE DEPENDENCIES:
# 1. 'readxl'
# 2. 'magrittr'
# 3. 'dplyr'
# 4. 'tidyr'
#
# NOTES: none
# ------------------------------------------

# Data import and wrangling
# library(readxl)
# library(janitor)
# library(magrittr)
# library(dplyr)
# library(stringr)
# library(tidyr)

# Data Import -------------------------------------------------------------
data_activity_fund <- read_xlsx(path = "data/AudienceFundKPI2017.xlsx", sheet = "Activity List", skip = 3)
data_demographics <- read_xlsx(path = "data/AudienceFundKPI2017.xlsx", sheet = "Data & Demographics")


# Data Clean --------------------------------------------------------------
# General Excel file cleaning
data_activity_fund <- data_activity_fund %>% 
  clean_names() %>% 
  remove_empty_rows() %>% 
  remove_empty_cols()
data_demographics <- data_demographics %>% 
  remove_empty_rows() %>% 
  remove_empty_cols()

# Data-specific cleaning
data_activity_fund <- data_activity_fund %>% 
  rename(VenueName = venue_name_s,
         VenuePostCode = venue_postcode_1st_half,
         FilmTitle = starts_with(match = "feature_film"),
         YearOfRelease = year_of_release,
         NumberOfScreenings = no_times_screened,
         TotalAdmissions = total_admissions)

# remove unecessary rows
data_demographics <- data_demographics[-c(1, 12, 13), ]
data_demographics <- data_demographics %>% 
  # pad out tibble with previous row's entry
  fill(x = X__1, .direction = "down") %>% 
  rename(Category = X__1,
         Field = starts_with(match = "DATA"),
         Value = X__2) %>% 
  select(Category, Field, Value) %>% 
  mutate(Category = ifelse(is.na(Category), "General", Category),
         Field = str_replace(string = Field, pattern = "Age ", replacement = "")) %>% 
  # remove "Total Responses"
  filter(Field != "Total Responses" & Field != "Total responses")