setwd("~/GitHub/coursera/05.ReproducibleResearch/PeerAssessment2")

library(data.table)
library(reshape)
library(ggplot2)
library(plyr)

stormData <- data.table(read.csv(".//repdata-data-StormData.csv"))
names(stormData) <- tolower(names(stormData))

stormData <- subset(stormData, select= c("evtype", "fatalities", "injuries", "propdmg", "propdmgexp", "cropdmg", "cropdmgexp"))

approved_list <- tolower(c("Astronomical Low Tide", "Avalanche", "Blizzard", "Coastal Flood", "Cold/Wind Chill", "Debris Flow", "Dense Fog", "Dense Smoke", "Drought", "Dust Devil", "Dust Storm", "Excessive Heat", "Extreme Cold/Wind Chill", "Flash Flood", "Flood", "Frost/Freeze", "Funnel Cloud", "Freezing Fog", "Hail", "Heat", "Heavy Rain", "Heavy Snow", "High Surf", "High Wind", "Hurricane (Typhoon)", "Ice Storm", "Lake-Effect Snow", "Lakeshore Flood", "Lightning", "Marine Hail", "Marine High Wind", "Marine Strong Wind", "Marine Thunderstorm Wind", "Rip Current", "Seiche", "Sleet", "Storm Surge/Tide", "Strong Wind", "Thunderstorm Wind", "Tornado", "Tropical Depression", "Tropical Storm", "Tsunami", "Volcanic Ash", "Waterspout", "Wildfire", "Winter Storm", "Winter Weather"))

match_char <- c("K", "M", "B")
exp10 <- 10 ^ c(3, 6, 9, 0)

stormData <- mutate(stormData, casualties = fatalities + injuries,
                    propdmg = propdmg * exp10[match(propdmgexp, match_char, nomatch=4)],
                    cropdmg = cropdmg * exp10[match(cropdmgexp, match_char, nomatch=4)],
                    econdmg = propdmg + cropdmg,
                    evtype = tolower(evtype)
                    )

stormData <- stormData[stormData$evtype %in% approved_list]
relevant <- subset(stormData, econdmg!=0 | casualties!=0, 
                   select=c("evtype", "fatalities", "injuries", "casualties", "propdmg", "cropdmg", "econdmg"))
relevant_sum <- ddply(relevant, .(evtype), colwise(sum))
relevant_melt <- melt(relevant_sum, id="evtype")

png("pophealth.png", width= 867, height=600)
ggplot(data = subset(relevant_melt, variable %in% c("fatalities", "injuries")), 
       aes(x=reorder(evtype, -value, sum), y=value/1000, fill = reorder(variable, -value, sum))) + 
  geom_bar(stat="identity") +
  scale_fill_discrete("", labels = c("Injuries", "Fatalities"), guide = guide_legend(rev = T)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  xlab("Event Type") +
  ylab("Casualties ('000s)") +
  ggtitle("Total Number of Casualties by event type (approved list)")
dev.off()

png("econ.png", width= 867, height=600)
ggplot(data = subset(relevant_melt, variable %in% c("propdmg", "cropdmg")), 
       aes(x=reorder(evtype, -value, sum), y=value/10^9, fill = reorder(variable, -value, sum))) + 
  geom_bar(stat="identity") +
  scale_fill_discrete("", labels = c("Property", "Crop"), guide = guide_legend(rev = T)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  xlab("Event Type") +
  ylab("Damages (US$ billions)") +
  ggtitle("Total Monetary Damage by event type (approved list)")
dev.off()
