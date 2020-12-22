# Wrangle data for generating required text and plot
data_rating <- data_survey %>% 
  filter(str_detect(string = question, pattern = "rate your experience of LEAFF")) %>% 
  # convert to integer to allow summation
  mutate(selection = as.integer(selection))

# Generate text for report
txt_rating <- data_rating %>% 
  # construct right table structure to generate text required
  select(question, selection) %>% 
  group_by(selection) %>% 
  tally() %>% 
  mutate(Percent = round(x = n/sum(n), digits = 2)) %>% 
  # pull info for report
  filter(selection %in% c(4, 5))
txt_rating <- sum(x = txt_rating$Percent)

if (txt_rating > 0.7) {
  txt_rating_conc <- c("the majority of", "successful")
} else if (txt_rating > 0.5) {
  txt_rating_conc <- c("over half of", "successful")
} else {
  txt_rating_conc <- c("some", "unsuccessful")
}