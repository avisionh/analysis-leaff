data_ethnicity <- data_survey %>% 
  filter(str_detect(string = Question, pattern = "ethnicity")) %>% 
  mutate(Response = as.integer(Response)) 

txt_ethnicity <- data_ethnicity %>% 
  select(Selection, Response) %>% 
  group_by(Selection) %>% 
  summarise(Total = sum(x = Response, na.rm = TRUE)) %>% 
  arrange(desc(Total)) %>% 
  head(1) %>% 
  select(Selection) %>% 
  pull()

# Logic to check if high rating of festival is linked to number of screenings
if (txt_ethnicity != "White - British" | txt_ethnicity != "White - European") {
  txt_ethnicity_conc <- c("promoting")
} else {
  txt_ethnicity_conc <- c("following wider UK trends on")
}