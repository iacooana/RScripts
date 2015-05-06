# Q1: Register an application in github and use that to get the time datasharing repo was created
rm(list=ls(all=TRUE))

library(httr)
library(httpuv)
endpoint <- oauth_endpoints("github")
myapp <- oauth_app("github", key="bc0654d5ac8d091ecd86", secret="38a591fc235c29d90d87d52d786faae5d9b22b90")
github_token <- oauth2.0_token(endpoint=endpoint, myapp, cache=FALSE)
gtoken <- config(token="1640f40f65c73edf387ca30c337c354a9aa3fb3f")

req <-GET("https://api.github.com/users/jtleek/repos")
json1=content(req)
library(utils)
library(jsonlite)
json2=jsonlite::fromJSON(toJSON(json1))
names(json2)
json2$created_at[json2$name=="datasharing"]

# Q2 & 3: Running SQL commands on the data frame read in from the csv
setwd("C:/Users/oana.iacovita/Documents/Data")
fileURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile = "./survey_data.csv")
surveyData <-read.table("survey_data.csv", sep=",", header=TRUE, quote="")
head(surveyData)
library(sqldf)
sqldf("select pwgtp1 from surveyData")
sqldf("select distinct AGEP from surveyData") # SQL Statements

#Q4: How many char are in the 10th, 20th, 30th and 100th line of code in the url below
con=url("http://biostat.jhsph.edu/~jleek/contact.html") #open connection
htmlCode=readLines(con)
close(con)
head(htmlCode)
htmlCode[10]
htmlCode[20]
htmlCode[30]
htmlCode[100]

# Q5: Get data from below and provide the sum of the 4th of 9 column (Nino3 SST)
setwd("C:/Users/oana.iacovita/Documents/Data")
fileURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileURL, destfile = "./getdata.for")
library(utils)
a<-read.fwf("getdata.for", widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
v<-as.numeric(a$V4)
n<-a$V4
s<-sum(n)
s








