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

#creating day of week column
relevant <- mutate(relevant, dayofweek=format(relevant$Date, "%a"))

#casting to numeric
relevant$Sub_metering_1 <- as.numeric(levels(relevant$Sub_metering_1))[relevant$Sub_metering_1]
relevant$Sub_metering_2 <- as.numeric(levels(relevant$Sub_metering_2))[relevant$Sub_metering_2]

#opening png device and plotting
png("plot3.png", width=480, height=480, pointsize=12)
plot(relevant$DateTime, relevant$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(relevant$DateTime, relevant$Sub_metering_2, type="l", col="red")
lines(relevant$DateTime, relevant$Sub_metering_3, type="l", col="blue")
legend("topright", lty=c(1,1), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
