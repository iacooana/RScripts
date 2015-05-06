library(graphics) # core plotting system; base system (plot, hist, boxplot)
#library(grDevices) #code for the various graphics devices 
#library(lattice) # uses grid package (xyplot,bwplot,levelplot)
#library(grid) #usually don't call this directly unless it's used via lattice
#library(ggplot2) 

#2 phases: initailize new plot & annotate plot
#plot(x,y) #plot is a basic function and can receive ?par gives a list of parameters that can be used
#hist(x)

#===============================
library(datasets)
hist(airquality$Ozone)
with (airquality, plot(Wind, Ozone))

#===============================
#Distribution of ozone by month
airquality <- transform(airquality, Month=factor(Month))
boxplot(Ozone ~ Month, airquality, xlab="Month", ylab="Ozone (ppb)") 

#===============================
#use the par function to change properties at the global level, in all graphs you are making
par(bg="gray")
hist(airquality$Ozone, col="aliceblue") #will now have a gray background
par("bg") # gives you the current value for all the par() arguments
par("mar") # margines;  4 sides of a plot, going clockwise
par("lty") # solid line
par("col") # color
par("mfrow") # default to 1 1 = 1 row and 1 column = 1 plot

#===============================
#plotting and annotating
library(datasets)
with (airquality, plot(Wind, Ozone))
title(main="Ozone and Wind in NYC") #Add a title

#===============================
# OR: plot the data one at a time based on month of May or not May
with (airquality, plot(Wind, Ozone, main="Ozone and Wind in NYC", type="n")) #type="n" sets up the plot but does not plot the data
with(subset(airquality, Month==5), points(Wind, Ozone, col="red")) # color the datapoints in the month of May
with(subset(airquality, Month!=5), points(Wind, Ozone, col="blue")) 
legend("topright", pch=1, col= c("red", "blue"), legend = c("May", "Other Months"))

#===============================
#Add a regression line to the plot
with (airquality, plot(Wind, Ozone, main="Ozone and Wind in NYC", pch=20)) #changed the default circle
model <- lm(Ozone ~ Wind, airquality) #liniar model on the data
abline(model, lwd=2, col="red")

#===============================
# Multiple Base plots on a single device: 1.Ozons vs. Wind and 2.Ozone vs. Solar Radiation
par(mfrow=c(1, 2)) #1 row, 2 columns for side by side plots
with (airquality, {
  plot(Wind, Ozone, main="Ozone and Wind")
  plot(Solar.R, Ozone, main="Ozone and Solar Radiation")
})

#===============================
# 3 plots on Ozone vs. Wind, Solar Radiation and Temperature
par(mfrow=c(1, 3), mar=c(4,4,2,1), oma=c(0,0,2,0)) #1 row, 3 columns for side by side plots; mar are smaller than default; outer margines to be larger than 0 to add title
with (airquality, {
  plot(Wind, Ozone, main="Ozone and Wind")
  plot(Solar.R, Ozone, main="Ozone and Solar Radiation")
  plot(Temp, Ozone, main="Ozone and Temperature")
  mtext("Ozone and Weather in NYC", outer=TRUE) #adds outter title
})


#===============================
#===============================
# Base system demo - options:
par(mfrow=c(1, 1)) #change back to 1 1
x<-rnorm(100)
y<-rnorm(100)
hist(x)
plot(x,y) # adds the name of the variables to the x and y axis

#===============================
# margins start at the bottom and go clock wise
par(mar=c(4,4,2,2)) #can change the margins
plot(x,y, pch=19) # 20 and 19=full circles; 2=triangles; 3=pluses; 4=X's

#===============================
# example(points) - can use to get demos on plotting
title("scatterplot")
text(-2,-2, "Label")
legend("topleft", legend="Data", pch=20) #topleft,bottomleft,topright,bottomright
fit<-lm(y ~ x)
abline(fit, lwd=3, col="blue") # if you change the lwd a new line is generated and put over the existent line

#===============================
# x and y labels, legend and regression line
plot(x,y,xlab="Weight", ylab="Height",main="Scatterplot", pch=20)
legend("topright", legend="Data", pch=20)
fit<-lm(y ~ x)
abline(fit, lwd=3, col="blue")

#===============================
# Multiple plots
z<-rnorm(100)
par(mfrow=c(1,2), mar=c(4,4,2,2))
plot(x,y,pch=20)
plot(x,z,pch=19)

#===============================
# 4 graphs displayed at the same time
par(mfrow=c(2,2))
plot(x,y)
plot(x,z)
plot(z,x)
plot(y,x)

#===============================
# Points function - subsetting by a group and plot them one at a time
par(mfrow=c(1,1))
a<-rnorm(100)
b<-a+rnorm(100)
g<- gl(2,50, labels=c("Male", "Female")) #separate data on groups of 50 each
plot(a,b, type="n") #make the plot, don't put the data in
points(x[g=="Male"], y[g=="Male"], col="green", pch=19)
points(x[g=="Female"], y[g=="Female"], col="blue", pch=19)

#===============================
# Plot to files; plot to PDF file 
setwd("C:/Users/oana.iacovita/Documents/Data")
pdf(file="myplot.pdf") #open PDF device
library(datasets)
with (airquality, plot(Wind, Ozone, main="Ozone and Wind in NYC")) 
dev.off() #close graphic device

#===============================
# multiple graphics devices; can only plot to one device at a time; 
dev.cur() #current device active; >=2

#===============================
# copy plots from one device to the other
library(datasets)
with (airquality, plot(Wind, Ozone, main="Ozone and Wind in NYC")) 
setwd("C:/Users/oana.iacovita/Documents/Data")

dev.copy(png, file="gryserplot_png.png")
dev.off() #close graphic device











