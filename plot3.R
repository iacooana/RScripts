# Clear variables and load r packages used
rm(list=ls(all=TRUE))
library(graphics)
library(data.table)

# Read all data in
data <- read.table("household_power_consumption.txt",header=TRUE, sep=";")

# Modify Date to be of Date class and subset only the data from 2007-02-01 and 2007-02-02
data$Date<- as.Date(data$Date, format="%d/%m/%Y")
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
subdata <- subset(data, data$Date>=date1 & data$Date <= date2)

# Add DateTime column and use strptime to make it of class POSIXlt
subdata["DateTime"] <- paste(subdata$Date, subdata$Time)
subdata$DateTime <- strptime(subdata$DateTime, format="%Y-%m-%d %H:%M:%S")

# Prepare data for plotting 
col <- colnames(subdata)[4:length(subdata)-1]
subdata[col] <- sapply(sapply(subdata[col], as.character), as.numeric)

# Create and plot to plot3.png
png("plot3.png", width = 480, height = 480)

par(bg="white")
with (subdata, 
      plot(DateTime, Sub_metering_1,
                    type="l", ylab="Energy sub metering", xlab="", col="black"))
lines(subdata$DateTime, subdata$Sub_metering_2, type = "l", col = "red")
lines(subdata$DateTime, subdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1)

dev.off() 



