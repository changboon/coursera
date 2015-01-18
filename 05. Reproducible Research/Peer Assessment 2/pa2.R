setwd("~/GitHub/coursera/05. Reproducible Research/Peer Assessment 2")

library(data.table)
library(reshape)
library(ggplot2)

stormData <- data.table(read.csv(".//repdata-data-StormData.csv"))
setkey(stormData, EVTYPE)
names(stormData)

#EVTYPE FATALITIES INJURIES 
pophealth <- stormData[, list(FATALITIES=sum(FATALITIES), INJURIES=sum(INJURIES)), by=list(EVTYPE)]
pophealth <- melt(pophealth, id="EVTYPE")

png("pophealth.png", width= 640, height=640)
qplot(EVTYPE, value, data=pophealth, facets=variable~.)
dev.off()

head(pophealth)

#EVTYPE PROPDMG PROPDMGEXP CROPDMG CROPDMGEXP
econ <- stormData[, list(PROPDMG=sum(PROPDMG), PROPDMGEXP=sum(PROPDMGEXP), CROPDMG=sum(CROPDMG), CROPDMGEXP=sum(CROPDMGEXP))
                  , by=list(EVTYPE)]
econ <- melt(econ, id="EVTYPE")
head(econ)

