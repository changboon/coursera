setwd("~/Github/coursera/04. Exploratory Analysis/Course Project 2")

library(ggplot2)
library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- merge(NEI, SCC, by.x="SCC", by.y="SCC")

baltimore <- data[data$fips=="24510",]
cut_baltimore <- baltimore[baltimore$type=="ON-ROAD",]
agg_baltimore <- aggregate(Emissions~year, cut_baltimore, sum)

losangeles <- data[data$fips=="06037",]
cut_losangeles <- losangeles[losangeles$type=="ON-ROAD",]
agg_losangeles <- aggregate(Emissions~year, cut_losangeles, sum)

agg_losangeles <- mutate(agg_losangeles, City = "Los Angeles")
agg_baltimore <- mutate(agg_baltimore, City = "Baltimore")

agg_baltimore$year <- as.Date(paste0(agg_baltimore$year,"-01-01"))
agg_losangeles$year <- as.Date(paste0(agg_losangeles$year,"-01-01"))

combined <- rbind(agg_baltimore, agg_losangeles)

png("plot6.png", width= 640, height=640)
qplot(year, Emissions, data=combined, facets=.~City, geom="line", main="Total PM2.5 Emissions Across Years from Motor"
      , xlab="Year", ylab="Emissions (Tons)")
dev.off()
