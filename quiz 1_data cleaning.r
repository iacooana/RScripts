#****************************************************************************************
# How many properties worth 1,000,000$ or more
#download data
setwd("C:/Users/oana.iacovita/Documents/Data")
fileURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "./communities.csv")
#list.files("./")

#open data, get the communities 
communitiesData <-read.csv("communities.csv")
#head(communitiesData)
x<-na.omit(communitiesData$VAL[communitiesData$VAL==24])
length(x)
#Q1:53
#****************************************************************************************

#Q2: FES has multiple variables per column

#****************************************************************************************
#Q3:get xlsx and get sum(dat$Zip*dat$Ext,na.rm=T) 
# Download xlsx from the web
xlsxURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(xlsxURL, destfile = "./gas1.xlsx", mode='wb')
list.files("./")

#read xlsx rows 18-23 and columns 7-15
library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./gas1.xlsx", sheetIndex=1, colIndex=colIndex,rowIndex=rowIndex)
dat
sum(dat$Zip*dat$Ext,na.rm=T) 
#A=36534720

#****************************************************************************************
#Q4: How many restaurants have zipcode 21231
library(XML)
library(RCurl)
XMLURL<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xData <- getURL(XMLURL)
rest <- xmlTreeParse(xData, useInternal=TRUE)
rootNode <-xmlRoot(rest)
names((rootNode))
zip <-xpathSApply(rootNode, "//zipcode", xmlValue)
sum(zip==21231)
#A = 127
#****************************************************************************************

#****************************************************************************************
#Q5: Which of the following methods is fastest way to calculate avg. value of a variable
csvURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(csvURL, destfile = "./house.csv")

ptm <- proc.time()
library(data.table)
DT<-fread("house.csv") #Data Table

mean(DT$pwgtp15,by=DT$SEX)

proc.time() - ptm











