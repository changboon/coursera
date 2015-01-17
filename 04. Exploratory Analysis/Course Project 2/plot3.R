setwd("~/Github/coursera/04. Exploratory Analysis/Course Project 2")

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- NEI[NEI$fips=="24510",]

agg_baltimore <- aggregate(Emissions~year+type, baltimore, sum)

agg_baltimore$year <- as.Date(paste0(agg_baltimore$year,"-01-01"))

png("plot3.png", width= 640, height=640)
qplot(year, Emissions, data=agg_baltimore, facets=.~type, geom="line", main="Total PM2.5 Emissions Across Years At Baltimore By Type"
      , xlab="Year", ylab="Emissions (Tons)")
dev.off()
