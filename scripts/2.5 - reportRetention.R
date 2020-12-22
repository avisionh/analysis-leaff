data_retention <- data_survey %>% 
  filter(str_detect(string = question, pattern = "previous LEAFF")) %>% 
  mutate(Selection_New = ifelse(str_detect(string = selection, pattern = "Yes"), "Yes", selection))

# Generate text for those who have returned from previous years
table_retention <- data_retention %>% 
  select(question, selection) %>% 
  filter(selection != "No, this is my first!") %>% 
  group_by(selection) %>% 
  tally() %>% 
  mutate(Percent = round(x = n/sum(n), digits = 2) * 100,
         Text = paste0(selection, " (", Percent, "%)")) 

txt_retention <- table_retention %>% 
  select(Text) %>% 
  # pull from dataframe to vector
  pull()

# For pie by separating out those who went before and those whose first time it is

table_retention <- data_retention %>% 
  select(Selection_New, selection) %>% 
  group_by(Selection_New) %>% 
  tally() %>% 
  mutate(Percent = round(x = n/sum(n), digits = 2))

txt_retention_new <- table_retention %>% 
  filter(Selection_New == "No, this is my first!") %>% 
  select(Percent) %>% 
  pull()

if (1 - txt_retention_new > 0.35) {
  txt_retention_stay <- c("sizeable" ,"effective")
} else
  txt_retention_stay <- c("small", "ineffective")