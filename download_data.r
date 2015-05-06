## Reads in CSV file from the web 
setwd("C:/Users/oana.iacovita/Documents/Data")
fileURL <-"https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile = "./cameras.csv")
list.files("./")

dateDownloaded <-date()
dateDownloaded

cameraData <-read.table("cameras.csv", sep=",", header=TRUE, quote="")
head(cameraData)


## Reads in XLSX file from the web; copies it down and then it opens it using the xlsx package
setwd("C:/Users/oana.iacovita/Documents/Data")
fileURL <-"https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileURL, destfile = "./camerasXLSX.xlsx")
list.files("./")

dateDownloaded <-date()
dateDownloaded

library(xlsx)
cameraDataXLSX<- read.xlsx("camerasXLSX.xlsx", sheetIndex=1, header=TRUE)
head(cameraDataXLSX)



## Reads in XML data and parses it out into R memory
library(XML)
XMLfileURL<-"http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(XMLfileURL, useInternal=TRUE)
rootNode <-xmlRoot(doc)
xmlName(rootNode)
names((rootNode))
rootNode[[1]] #same as you access an element of a list in R
rootNode[[1]][[1]] #subsetting lists
xmlSApply(rootNode,xmlValue) #loop through the elements of a node and get alll the values 
xmlSApply(rootNode[[1]],xmlValue) 


xpathSApply(rootNode, "//name", xmlValue) #get the XML values for the name nodes
xpathSApply(rootNode, "//price", xmlValue)#get the XML values for the price nodes



##Get data from the source code of a webpage
URL<-"http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <-htmlTreeParse(URL, useInternal=TRUE)
scores <-xpathSApply(doc, "//li[@class='score']", xmlValue)
teams<-xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores


##Reading in JSON data
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner) #get info from owner column
names(jsonData$owner$login) #get login from owner

#data frames to JSON
head(iris) #print part of iris data set
myj <-toJSON(iris, pretty=TRUE) #from data set to JSON
iris2 <- fromJSON(myj) #from JSON back to data
cat(myj) #prints out JSON output
head(iris2) #prints out converted output


#using data.table package
library(data.table)
df<-data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9)) #Data Frame
dt<-data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9)) #Data Table
head(df,3)
head(dt,3)
tables() #see all tables in memory
dt[2,]
dt[c(2,3)] # 2nd and 3rd rows from the table
dt[,table(y)] #can perform any function on the dt; get a table on the y values
dt[,list(mean(x),sum(z))] #can perform any function on the dt; get the mean of the x and the sum of the z
dt[,w:=z^2] #add a new column with the values of z; this does not get a 2nd table in memory
dt

set.seed(123)
d<-data.table(x=sample(letters[1:3], 1E5, TRUE)) # data table with about 100000 a's, b's and c's in it
d[, .N, by=x] #count the number of times each of these occur

#setting the keys of a table
dtt <- data.table(x=rep(c("a","b","c"),each=100), y=rnorm(300))
setkey(dtt,x) #set the key of dtt to be the column x
dtt['a'] #subsetts the data based on the keys

#use keys to merge 2 tables
d1<-data.table(x=c('a','b','c','d1'), y=1:4)
d2<-data.table(x=c('a','b', 'd2'), z=5:7)
setkey(d1,x)
setkey(d2,x)
merge(d1,d2)

#Reading from MySQL
db_connection <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.uscs.edu")
result<- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)  #TRUE when you actually disconnect

# MySQL: connect to hg19 db and look at tables and Table1 fields
hg19_database <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.uscs.edu")
allTables <- dbListTables(hg19_database)
length(allTables) #get the number of tables in the h19 db
dbListFields(hg19_database, "Table1")
dbGetQuery(hg19, "select count(*) from Table1") #How many rows does Table1 have

# MySQL: select subset of data
query <- dbSendQuery(h19_database, "Select * from Table 1 where Match between 1 and 3") #send query to the db
affMiss <- fetch(query) #get response to the query back
affMiss_Small <- fetch(query, n=10); dbClearResult(query); #Brings back only top 10 records; clear the query from the database

# Read from HDF5 (Hierarchical Data Format)
#source("http://bioconductor.org/biocLite.R"); biocLite("rhdf5")
library(rhdf5)
created =h5createFile("example.h5")
created
# Create groups on multiple levels in hdf5
created=h5createGroup("example.h5", "foo")
created=h5createGroup("example.h5", "baa")
created=h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")

#Add data to hdf5
A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A")
B= array(seq(0.1,2.0,by=0.1), dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

# hdf5: create new data frame and write it to the top level group
df = data.frame(1L:5L, seq(0,1,length.out=5), c("ab", "cde", "fghi", "a", "s"),
                stringsAsFactors=FALSE)
h5write(df,"example.h5", "df")
h5ls("example.h5")

# hdf5: read data from hdf5 
readA=h5read("example.h5","foo/A") #specific dataset
readB=h5read("example.h5","foo/foobaa/B") #sub-datasets
readC=h5read("example.h5","df") #top level datasets
readA

# From the Web (Webscraping)
# Web:  Read from relatively open, easily accesible websites
con=url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en") #open connection
htmlCode=readLines(con)
close(con)
head(htmlCode)

# Web:  Using XML library to read
library(XML)
url<- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <-htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

# Web: Using httr package to read - similar to XML package
# httr can do get, post, put and delete depending on the requests
# works well with Facebook, Google, Twitter, Github, etc.
library(httr)
html2=GET(url) 
content2 = content(html2, as="text") #extract data into a big text line
parsedHtml = htmlParse(content2, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

# Web: accessing web with user and pass
pg2= GET("http://httpbin.org/basic-auth/user/passwd",
         authenticate("user","passwd"))
pg2
names(pg2) #differnt components of the cookies

# Using handles to authenticate
google=handle("http://google.com") #cookies remain with the website; no need to authenticate again
pg1=GET(handle=google, path="/")
pg2=GET(handle=google, path="search")















