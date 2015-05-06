rm(list=ls(all=TRUE))

# Q1: Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
# What is the value of the 123 element of the resulting list?
setwd("C:/Users/oana.iacovita/Documents/Data")
fileURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
download.file(fileURL, destfile = "./acs_id.csv")
a <-read.csv("acs_id.csv",header=TRUE)
n<-names(a)
sn <-strsplit(n, "\\wgtp")
sn[[123]] 
#A: "" "15"

# Q2: Remove the commas from the GDP numbers in millions of dollars and average them. What is the average? 
setwd("C:/Users/oana.iacovita/Documents/Data")
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
download.file(url, destfile = "./gdp_text.csv")
g <-read.csv("gdp_text.csv",header=FALSE, skip=5, na.strings="")
library(dplyr)
gd<-na.omit(select(g, V1,V2,V4,V5)) 
names(gd)<- c("CountryCode", "Ranking", "Economy", "GDP") 
v<-as.numeric(gsub(",", "", gd$GDP))
library(base)
m<-mean(v)
#A: 377652.4

# Q3:  what is a regular expression that would allow you to count the number of countries whose name begins with "United"? 
# Assume that the variable with the country names in it is named countryNames. How many countries begin with United? 
e<-length(grep("^United",gd$Economy))
#A: 3 occurences

# Q4: Match the data based on the country shortcode. 
# Of the countries for which the end of the fiscal year is available, how many end in June? 
EDU_URL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(EDU_URL, destfile = "./EDU.csv")
edu <-read.csv("EDU.csv",header=TRUE)
match<-merge(x=gd, y=edu, by="CountryCode", all=TRUE)
n<-as.character(match$Special.Notes)
ma<-match[grepl("Fiscal year end: June",match$Special.Notes),]
tot<-length(ma$Special.Notes)
#A: 13

# Q5: How many values were collected in 2012? How many values were collected on Mondays in 2012?
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
y<-format(sampleTimes, "%Y")
l<-length(grep("2012",y))
my<-format(sampleTimes, "%Y %A")
myl<-length(grep("2012 Monday", my))
l
myl
#A: 250, 47







