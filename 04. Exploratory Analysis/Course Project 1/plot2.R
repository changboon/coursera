setwd("~/GitHub/EDAP1")

#loading required libraries
library(data.table)
library(dplyr)

#reading file into memory
DT <- data.table(read.table("household_power_consumption.txt", sep=";", header=TRUE))

#filtering Date
relevant <- filter(DT, Date=="1/2/2007" | Date=="2/2/2007")

#formating Date
relevant$DateTime <- as.POSIXct(paste(relevant$Date, relevant$Time), format="%d/%m/%Y %H:%M:%S") 

#filtering data to include only relevant
relevant <- filter(relevant, Global_active_power!="?")

#creating day of week column
relevant <- mutate(relevant, dayofweek=format(relevant$Date, "%a"))

#casting to numeric
relevant$Global_active_power <- as.numeric(levels(relevant$Global_active_power))[relevant$Global_active_power]

#opening png device and plotting
png("plot2.png", width=480, height=480, pointsize=12)
plot(relevant$DateTime, relevant$Global_active_power,type="l", ylab="Global Active Power (killowatts)", xlab= "")
dev.off()
