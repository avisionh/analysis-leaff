# Create levels so we capture all responses and in right order
lvls <- c("Very likely", "Likely", "Unlikely")

# Construct table for presentation
table_recommend <- data_survey %>% 
  filter(str_detect(string = question, pattern = "recommend LEAFF to a friend")) %>% 
  mutate(selection = as.integer(selection)) %>% 
  select(question, selection) %>% 
  group_by(selection) %>% 
  tally() %>% 
  mutate(Percent = round(x = n/sum(n), digits = 2)) 

table_future <- table_recommend %>% 
  mutate(Percent = paste0(Percent * 100, "%"))

# Generate text
txt_recommend <- table_recommend %>% 
  filter(selection %in% c(4, 5)) %>% 
  mutate(PercentFinal = sum(x = Percent)) %>% 
  distinct(PercentFinal) %>% 
  pull()

if (txt_recommend > 0.5 & txt_rating > 0.5) {
  txt_recommend_conc <- "reinforces"
} else if((txt_recommend < 0.5 & txt_rating > 0.5) | (txt_recommend > 0.5 & txt_recommend < 0.5)) {
  txt_recommend_conc <- "conflicts with"
}