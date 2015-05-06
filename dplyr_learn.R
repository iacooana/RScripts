mydf <-read.csv(path2csv,stringsAsFactors=FALSE)
dim(mydf) # dimensions of mydf
head(df) #view data
library(dplyr)
packageVersion("dplyr") # should have version 0.4.1
cran <- tbl_df(mydf) #load the data into what the package authors call a 'data frame tbl' or 'tbl_df'; main advantage to using a tbl_df over a regular data frame is the printing

#core functions for dplyr:  select(), filter(), arrange(), mutate(),| and summarize()
#select
select(cran, ip_id, package, country) #select only a few variables
select (cran, r_arch:country) # all columns starting from r_arch and ending with country; can do reverse order too
select (cran, -time) # everything except time column

#filter
filter(cran, package=="swirl") #select only the rows that meet the criteria for the package column
filter(cran, r_version=="3.1.1", country=="US") #can use multiple columns and criteriae
filter(cran, country == "US" | country == "IN") # US or IN
filter(cran, !is.na(r_version)) # all rows excluding NAs in r_version

#arrange
arrange(cran2, ip_id) #arrange data based on ip_id (ascending)
arrange(cran2, desc(ip_id)) #descending order

#mutate
mutate(cran3, size_mb=size/ 2^20) #add a new column for MB by using the values from the size column
mutate(cran3, size_mb=size/ 2^20, size_gb=size_mb/ 2^10) # add 2 new columns for MB and GB based on existing column

#bind_rows
bind_rows(passed, failed)

# powerful if applied to grouped data
summarize(cran, avg_bytes=mean(size)) # gives you the mean of the size in one line

by_package <- group_by(cran,package) #groups data by package
summarize(by_package, m=mean(size, na.rm=TRUE)) # means based on each package

# using summary to calculate a few things based on existing columns
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

quantile(pack_sum$count, probs=0.99) # determine what is the 99% number of downloads
top_counts<-filter(pack_sum, count>679) #find out the top 1 % based on the previous result for 99%=679

View(top_counts) #goes beyond the 10 rows displayed by dplyr to see all data

#group_by() and chaining method (%>%); allows function to act on the result of a function to the left
result3 <-
  cran %>%
  group_by(package) %>%
  summarize(count = n(),
            unique = n_distinct(ip_id),
            countries = n_distinct(country),
            avg_bytes = mean(size)
  ) %>%
  filter(countries > 60) %>%
  arrange(desc(countries), avg_bytes)

# Print result to console
  cran %>%
  select(ip_id, country, package, size) %>%
  print

# using chaining to do various things on the data
  cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
  arrange(desc(size_mb)) %>% # Your call to arrange() goes here
  print

# rename
cran <- rename(cran, ip_id=ID, package = pkg)





