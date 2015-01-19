setwd("~/GitHub/coursera/05. Reproducible Research/Peer Assessment 2")

library(data.table)
library(reshape)
library(ggplot2)
library(plyr)

stormData <- data.table(read.csv(".//repdata-data-StormData.csv"))

#EVTYPE FATALITIES INJURIES 
pophealth <- stormData[, list(FATALITIES=sum(FATALITIES), INJURIES=sum(INJURIES)), by=list(EVTYPE)]
pophealth <- mutate(pophealth, TotalHarm = FATALITIES + INJURIES)
totalHarm <- subset(pophealth[order(-rank(TotalHarm))], , select=c(EVTYPE, TotalHarm))[1:10] 
totalHarm <- melt(totalHarm, id="EVTYPE")
fatalities <- subset(pophealth[order(-rank(FATALITIES))], , select=c(EVTYPE, FATALITIES))[1:10] 
fatalities <- melt(fatalities, id="EVTYPE")
injuries <- subset(pophealth[order(-rank(INJURIES))], , select=c(EVTYPE, INJURIES))[1:10] 
injuries <- melt(injuries, id="EVTYPE")
pophealth <- rbind(totalHarm, fatalities, injuries)

tornado <- pophealth[pophealth$EVTYPE == "TORNADO",]
pophealth <- pophealth[pophealth$EVTYPE != "TORNADO",] #remove tornado because most are from tornado

png("pophealth.png", width= 800, height=640)
ggplot(data=pophealth, aes(x=reorder(EVTYPE, -value), y=value)) + 
  geom_bar(stat="identity") +
  facet_grid(variable ~ .) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  xlab("Event Type") +
  ylab("Number affected (Pax)")
dev.off()

head(pophealth)

#EVTYPE PROPDMG PROPDMGEXP CROPDMG CROPDMGEXP
econ <- stormData[, list(PROPDMG=sum(PROPDMG), PROPDMGEXP=sum(PROPDMGEXP), CROPDMG=sum(CROPDMG), CROPDMGEXP=sum(CROPDMGEXP))
                  , by=list(EVTYPE)]
econ <- melt(econ, id="EVTYPE")
head(econ)

