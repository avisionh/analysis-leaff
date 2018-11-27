# Create levels so we capture all responses and in right order
lvls <- c("Very likely", "Likely", "Unlikely")

# Construct table for presentation
table_recommend <- data_survey %>% 
  filter(str_detect(string = Question, pattern = "23. How likely is")) %>% 
  mutate(Choice = factor(x = Choice, levels = lvls), Response = as.integer(Response)) %>% 
  select(Choice, Response) %>% 
  group_by(Choice) %>% 
  summarise(Total = sum(Response, na.rm = TRUE)) %>% 
  mutate(Percent = round(x = Total/sum(Total), digits = 2)) 

table_future <- table_recommend %>% 
  mutate(Percent = paste0(Percent * 100, "%"))

# Generate text
txt_recommend <- table_recommend %>% 
  filter(Choice %in% c("Very likely", "Likely")) %>% 
  mutate(PercentFinal = sum(x = Percent)) %>% 
  distinct(PercentFinal) %>% 
  pull()

if (txt_recommend > 0.5 & txt_rating > 0.5) {
  txt_recommend_conc <- "reinforces"
} else if((txt_recommend < 0.5 & txt_rating > 0.5) | (txt_recommend > 0.5 & txt_recommend < 0.5)) {
  txt_recommend_conc <- "conflicts with"
}