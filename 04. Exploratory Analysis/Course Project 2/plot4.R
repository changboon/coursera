setwd("~/Github/coursera/04. Exploratory Analysis/Course Project 2")

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- merge(NEI, SCC, by.x="SCC", by.y="SCC")
x<-grep("[ ]*[Cc]oal[ ]*",data$EI.Sector)
cut_data <- data[x,]
agg_data <- aggregate(Emissions~year, cut_data, sum)

agg_data$year <- as.Date(paste0(agg_data$year,"-01-01"))

png("plot4.png", width= 640, height=640)
qplot(year, Emissions/1000, data=agg_data, geom="line", main="Total PM2.5 Emissions Across Years in US Of Coal Source"
      , xlab="Year", ylab="Emissions (1,000 Tons)")
dev.off()
