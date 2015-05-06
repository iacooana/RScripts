rm(list=ls(all=TRUE))

#Q1: Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products
# ACR= 3 ; AGS = 6 
setwd("C:/Users/oana.iacovita/Documents/Data")
fileURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "./acs.csv")
#list.files("./")
acs <-read.csv("acs.csv",header=TRUE)
agricultureLogical <- acs$ACR==3 & acs$AGS==6
which(agricultureLogical)
#A: 125,238,262

#Q2: read in the following picture of your instructor into R 
library(jpeg)
setwd("C:/Users/oana.iacovita/Documents/Data")
url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url, destfile = "./jeff.jpg",mode="wb")
photo<-readJPEG("./jeff.jpg", native = TRUE)
quantile(photo, probs=c(0.30, 0.80))
#A: -15259150 and -10575416

#Q3: Load the Gross Domestic Product data for the 190 ranked countries and the data set on educational data; 
#Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). 
#What is the 13th country in the resulting data frame? 
library(dplyr)
setwd("C:/Users/oana.iacovita/Documents/Data")
GDP_URL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
EDU_URL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(GDP_URL, destfile = "./GDP.csv")
download.file(EDU_URL, destfile = "./EDU.csv")
gdp <-read.csv("GDP.csv",header=FALSE, skip=5, na.strings="") #Read in CSV and skip the first lines and set empty strings as NAs

gdpDS<-na.omit(select(gdp, V1,V2,V4,V5)) #keep only valid columns, omitting the NAs
names(gdpDS)<- c("CountryCode", "Ranking", "Economy", "GDP") #rename columns
gdpDS$Ranking<-as.numeric(as.character(gdpDS$Ranking)) #change Ranking from factor to numeric (through character)

edu <-read.csv("EDU.csv",header=TRUE)
#intersect(names(edu), names(gdpDS)) #verify common column has the same name

match<-merge(x=gdpDS, y=edu, by="CountryCode", all.x=TRUE)
countMatched<-length(match$CountryCode)
countMatched # 234 matches with NAs and 190 without NAs

a<- arrange(match, desc(Ranking))
x<- select(a, CountryCode, Long.Name, Ranking, Income.Group)
x[13,] #the 13th member of the df ordered desc based on Ranking

# Q4: Average GDP ranking for the "High income: OECD" and "High income: nonOECD" group
sub<-a[(a$Income.Group %in% c("High income: OECD","High income: nonOECD")), ]
library(base)
u<-(
  sub %>%
    group_by(Income.Group)%>%
      summarise_each(funs(mean(.,na.rm=TRUE)))
)
View(u)
#A: 32.96667 and 91.91304

#Q5: Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
#How many countries are Lower middle income but among the 38 nations with highest GDP?
library(Hmisc)
x$RankingGroups= cut2(x$Ranking,g=5)
table(x$RankingGroups, x$Income.Group)
#A:5 countries




