data_retention <- data_survey %>% 
  filter(str_detect(string = Question, pattern = "1. Did you attend")) %>% 
  mutate(Response = as.integer(Response),
         Selection_New = ifelse(str_detect(string = Selection, pattern = "Yes"), "Yes", Selection))

# Generate text for those who have returned from previous years
table_retention <- data_retention %>% 
  select(Selection, Response) %>% 
  filter(Selection != "This is my first!") %>% 
  group_by(Selection) %>% 
  summarise(Total = sum(x = Response, na.rm = TRUE)) %>% 
  mutate(Percent = round(x = Total/sum(Total), digits = 2) * 100,
         Text = paste0(Selection, " (", Percent, "%)")) 

txt_retention <- table_retention %>% 
  select(Text) %>% 
  # pull from dataframe to vector
  pull()

# For pie by separating out those who went before and those whose first time it is

table_retention <- data_retention %>% 
  select(Selection_New, Response) %>% 
  group_by(Selection_New) %>% 
  summarise(Total = sum(x = Response, na.rm = TRUE)) %>% 
  mutate(Percent = round(x = Total/sum(Total), digits = 2))

txt_retention_new <- table_retention %>% 
  filter(Selection_New == "This is my first!") %>% 
  select(Percent) %>% 
  pull()

if (1 - txt_retention_new > 0.35) {
  txt_retention_stay <- c("sizeable" ,"effective")
} else
  txt_retention_stay <- c("small", "ineffective")