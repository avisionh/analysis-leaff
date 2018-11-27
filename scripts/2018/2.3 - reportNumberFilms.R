data_no_film <- data_survey %>% 
  filter(str_detect(string = Question, pattern = "15. How many movies")) %>% 
  mutate(Response = as.integer(Response)) 

txt_no_film <- data_no_film %>% 
  select(Choice, Response) %>% 
  group_by(Choice) %>% 
  summarise(Total = sum(x = Response, na.rm = TRUE)) %>% 
  arrange(desc(Total)) %>% 
  head(1) %>% 
  select(Choice) %>% 
  pull()

# Logic to check if high rating of festival is linked to number of screenings
if (txt_rating > 0.65 & (txt_no_film == "14+" | txt_no_film == "8-13")) {
  txt_no_film_conc <- c("supports", "enjoyed their experience so much they wanted to watch more screenings")
} else {
  txt_no_film_conc <- c("conflicts with", "may have other reasons for not attending more screenings, such as work or studies")
}