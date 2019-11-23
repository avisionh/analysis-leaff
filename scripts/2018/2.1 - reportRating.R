# Wrangle data for generating required text and plot
data_rating <- data_survey %>% 
  filter(str_detect(string = Question, pattern = "rate your experience of LEAFF")) %>% 
  # convert to integer to allow summation
  mutate(Response = as.integer(Response))

# Generate text for report
txt_rating <- data_rating %>% 
  # construct right table structure to generate text required
  select(Selection, Response) %>% 
  group_by(Selection) %>% 
  summarise(Total = sum(x = Response, na.rm = TRUE)) %>% 
  mutate(Percent = round(x = Total/sum(Total), digits = 2)) %>% 
  # pull info for report
  filter(Selection %in% c("Very good", "Good"))
txt_rating <- sum(x = txt_rating$Percent)

if (txt_rating > 0.7) {
  txt_rating_conc <- c("the majority of", "successful")
} else if (txt_rating > 0.5) {
  txt_rating_con <- c("over half of", "successful")
} else {
  txt_rating_conc <- c("some", "unsuccessful")
}