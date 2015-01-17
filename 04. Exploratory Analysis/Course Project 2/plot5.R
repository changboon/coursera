setwd("~/Github/coursera/04. Exploratory Analysis/Course Project 2")

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- merge(NEI, SCC, by.x="SCC", by.y="SCC")

baltimore <- data[data$fips=="24510",]
cut_baltimore <- baltimore[baltimore$type=="ON-ROAD",]
agg_baltimore <- aggregate(Emissions~year, cut_baltimore, sum)

agg_baltimore$year <- as.Date(paste0(agg_baltimore$year,"-01-01"))

png("plot5.png", width= 640, height=640)
qplot(year, Emissions, data=agg_baltimore, geom="line", main="Total PM2.5 Emissions Across Years in Baltimore from Motor"
      , xlab="Year", ylab="Emissions (Tons)")
dev.off()
