setwd("~/GitHub/coursera/05. Reproducible Research/Peer Assessment 2")

library(data.table)
library(reshape)
library(ggplot2)
library(plyr)

stormData <- data.table(read.csv(".//repdata-data-StormData.csv"))
names(stormData) <- tolower(names(stormData))

#evtype fatalities injuries 
pophealth <- stormData[, list(fatalities=sum(fatalities), injuries=sum(injuries)), by=list(evtype)]
pophealth <- mutate(pophealth, casualties = fatalities + injuries)
casualties <- subset(pophealth[order(-rank(casualties))], , select=c(evtype, casualties))[1:10] 
 <- melt(totalHarm, id="evtype")
fatalities <- subset(pophealth[order(-rank(fatalities))], , select=c(evtype, fatalities))[1:10] 
fatalities <- melt(fatalities, id="evtype")
injuries <- subset(pophealth[order(-rank(injuries))], , select=c(evtype, injuries))[1:10] 
injuries <- melt(injuries, id="evtype")
pophealth <- rbind(totalHarm, fatalities, injuries)

tornado <- pophealth[pophealth$evtype == "TORNADO",]
pophealth <- pophealth[pophealth$evtype != "TORNADO",] #remove tornado because most are from tornado

png("pophealth.png", width= 800, height=640)
ggplot(data=pophealth, aes(x=reorder(evtype, -value), y=value)) + 
  geom_bar(stat="identity") +
  facet_grid(variable ~ .) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  xlab("Event Type") +
  ylab("Number affected (Pax)")
dev.off()

match_char <- c("K", "M", "B")
exp10 <- 10 ^ c(3, 6, 9, 0)



#evtype PROPDMG PROPDMGEXP CROPDMG CROPDMGEXP
econ <- stormData[, list(PROPDMG=sum(PROPDMG), PROPDMGEXP=sum(PROPDMGEXP), CROPDMG=sum(CROPDMG), CROPDMGEXP=sum(CROPDMGEXP))
                  , by=list(evtype)]
econ <- melt(econ, id="evtype")
head(econ)

