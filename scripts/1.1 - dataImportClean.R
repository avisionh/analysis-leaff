# --------------------- #
# 0 - dataImportClean #
# --------------------- #

# ------------------------------------------
# DESC: loads, and cleans Excel data into suitable format for analysis
# SCRIPT DEPENDENCIES: none

# NOTES: none
# ------------------------------------------

# Data import and wrangling
library(googledrive)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)

drive_auth()

# Data Import -------------------------------------------------------------
file_temp <- tempfile(fileext = ".zip")
dl <- drive_download(file = as_id(x = "https://drive.google.com/file/d/1_lYaacu1CKJA83X7laevBDpXE_0vi_Jy/view?usp=sharing"),
                     path = file_temp,
                     overwrite = TRUE)
out <- unzip(zipfile = file_temp, exdir = tempdir())
data_survey <- read_csv(file = out)

rm(file_temp, dl, out)

# Data Clean --------------------------------------------------------------
data_survey <- data_survey %>% 
  as_tibble() %>% 
  mutate(Id = row_number()) %>% 
  pivot_longer(cols = !c("Id", "Timestamp", "Which film screening did you attend?"),
               names_to = "Question",
               values_to = "Selection",
               values_transform = list(Selection = as.character)) %>% 
  # separate multiple-choice selection into rows
  separate_rows("Selection", sep = ";") %>% 
  rename_with(.cols = everything(), 
              .fn = ~ tolower(x = str_replace(string = ., 
                                              pattern = ' ', 
                                              replacement = '_')))

# store in folder as cannot authorise google when calling this script elsewhere
write_csv(x = data_survey,
          file = 'data/data_survey.csv')