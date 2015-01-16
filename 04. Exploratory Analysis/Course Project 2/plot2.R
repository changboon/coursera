setwd("~/coursera/04. Exploratory Analysis/Course Project 2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- NEI[NEI$fips=="24510",]

agg_baltimore <- aggregate(Emissions~year, baltimore, sum)

agg_baltimore$year <- as.Date(paste0(agg_baltimore$year,"-01-01"))

png("plot2.png")
with(agg_baltimore, plot(year,Emissions, type="l", 
                  main="Total PM2.5 Emissions at Baltimore City Across Years", 
                  xlab="Year", ylab="Emissions (million tons)"))
dev.off()
