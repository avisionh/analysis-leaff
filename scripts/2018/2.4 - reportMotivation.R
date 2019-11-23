data_motivation <- data_survey %>% 
  filter(str_detect(string = Question, pattern = "main motivation")) %>% 
  mutate(Response = as.integer(Response)) %>% 
  select(Selection, Response) %>% 
  group_by(Selection) %>% 
  summarise(Total = sum(Response, na.rm = TRUE)) %>% 
  mutate(Percent = round(x = Total/sum(Total), digits = 2))

# Create text for top threee reasons for attending festival
txt_motivation <- data_motivation %>% 
  arrange(desc(Total)) %>% 
  head(3) %>% 
  mutate(String = paste0(Selection, sep = " (", paste0(Percent*100, "%"), sep = ")")) %>% 
  select(String) %>% 
  pull()
txt_motivation <- paste0(txt_motivation[1], ", ", txt_motivation[2], " and ", txt_motivation[3])