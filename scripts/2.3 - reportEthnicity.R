# different options to previous year
data_ethnicity <- data_survey %>% 
  filter(str_detect(string = question, pattern = "ethnicity"))

txt_ethnicity <- data_ethnicity %>% 
  select(question, selection) %>% 
  group_by(selection) %>% 
  tally() %>% 
  arrange(desc(n)) %>% 
  head(1) %>% 
  select(selection) %>% 
  pull()

# Logic to check if high rating of festival is linked to number of screenings
if (txt_ethnicity != "English/Welsh/Scottish/Northern Irish/British" & txt_ethnicity != "Any other White background") {
  txt_ethnicity_conc <- c("promoting")
} else {
  txt_ethnicity_conc <- c("following wider UK trends on")
}