setwd("~/coursera/04. Exploratory Analysis/Course Project 2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

agg_df <- aggregate(Emissions~year, NEI, sum)

agg_df$year <- as.Date(paste0(agg_df$year,"-01-01"))
agg_df$Emissions <- agg_df$Emissions/1000000

png("plot1.png")
with(agg_df, plot(year,Emissions, type="l", 
                  main="Total PM2.5 Emissions Across Years", 
                  xlab="Year", ylab="Emissions (million tons)"))
dev.off()

