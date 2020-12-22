data_motivation <- data_survey %>% 
  filter(str_detect(string = question, pattern = "event/screening do any of the following")) %>% 
  select(question, selection) %>% 
  group_by(selection) %>% 
  tally() %>% 
  mutate(Percent = round(x = n/sum(n), digits = 2))

# Create text for top threee reasons for attending festival
txt_motivation <- data_motivation %>% 
  arrange(desc(n)) %>% 
  head(3) %>% 
  mutate(String = paste0(selection, sep = " (", paste0(Percent * 100, "%"), sep = ")")) %>% 
  select(String) %>% 
  pull()
txt_motivation <- paste0(txt_motivation[1], ", ", txt_motivation[2], " and ", txt_motivation[3])