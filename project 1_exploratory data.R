# Clear variables and load r packages used
rm(list=ls(all=TRUE))
library(graphics)
library(data.table)
setwd("~/Data")

# Read all data in
data <- read.table("household_power_consumption.txt",header=TRUE, sep=";")

# Modify Date to be of Date class and subset only the data from 2007-02-01 and 2007-02-02
data$Date<- as.Date(data$Date, format="%d/%m/%Y")
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
subdata <- subset(data, data$Date>=date1 & data$Date <= date2)

# Prepare data for plotting by changing columns with values from character to numeric
subdata$Global_active_power<- as.numeric(as.character(subdata$Global_active_power))

# Plot 1 =========================================
# Create and plot to plot1.png
png("plot2.png", width = 480, height = 480)
par(bg="white")
hist(subdata$Global_active_power, 
     col="red", main="Global Active Power", 
     xlab="Global Active Power (killowatts)")
dev.off() 

# Plot 2 =========================================













