rm(list=ls(all=TRUE))

library(tidyr)

# ?gather() # used when noticing columns that are not variables
# It's important to understand what each argument to gather() means.
# The data argument, students, gives the name of the original dataset.
# The key and value arguments -- sex and count, respectively -- give the column names for our tidy dataset. 
# The final argument, -grade, says that we want to gather all columns EXCEPT the grade column 
# (since grade is already a proper column variable.)
gather(students, sex, count, -grade) #except grade
res<-gather(students2, sex_class, count, -grade)

#?separate()
#Separate the column into two to get tidy data with one variable per column
separate(data=res, col=sex_class, into=c("sex", "class"))

OR:
  students2 %>%
  gather(sex_class, count, -grade) %>%
  separate(sex_class, into=c("sex", "class")) %>%
  print

# multiple columns
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  mutate(class=extract_numeric(class))%>%
  print

#unique
gradebook <- students4 %>%
  select(id, class, midterm, final) %>%
  unique() %>%
  print

#replace with another df with a new status column
passed<- passed %>% mutate(status="passed")

# SAT scores
sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, into=c("part","sex")) %>%
  print

sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  group_by(part, sex) %>%
  mutate(total=sum(count),prop=count/total) %>% 
  print





