setwd("~/GitHub/coursera/05. Reproducible Research/Peer Assessment 2")

library(data.table)

stormData <- data.table(read.csv(".//repdata-data-StormData.csv"))
setkey(stormData, EVTYPE)
names(stormData)

#EVTYPE FATALITIES INJURIES 
pophealth <- stormData[, list(FATALITIES=sum(FATALITIES), INJURIES=sum(INJURIES)), by=list(EVTYPE)]
head(pophealth)

#EVTYPE PROPDMG PROPDMGEXP CROPDMG CROPDMGEXP
econ <- stormData[, list(PROPDMG=sum(PROPDMG), PROPDMGEXP=sum(PROPDMGEXP), CROPDMG=sum(CROPDMG), CROPDMGEXP=sum(CROPDMGEXP))
                  , by=list(EVTYPE)]
head(econ)
