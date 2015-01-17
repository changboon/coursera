setwd("~/GitHub/EDAP1")

#loading required libraries
library(data.table)
library(dplyr)

#reading file into memory
DT <- data.table(read.table("household_power_consumption.txt", sep=";", header=TRUE))

#formating Date
DT$Date <- as.Date(DT$Date,"%d/%m/%Y")

#filtering data to include only relevant
relevant <- filter(DT, Date==as.Date("2007-02-01") | Date==as.Date("2007-02-02"))
relevant <- filter(relevant, Global_active_power!="?")

#casting to numeric
relevant$Global_active_power <- as.numeric(levels(relevant$Global_active_power))[relevant$Global_active_power]

#opening png device and plotting
png("plot1.png", width=480, height=480, pointsize=12)
hist(relevant$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
