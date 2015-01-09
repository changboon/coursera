setwd("~/coursera/03. Obtaining and Cleaning Data/quiz 04")
if (!file.exists("data")) {
  dir.create("data")
}
if (!file.exists("./data/AmericanCommunitySurvey.csv")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl, destfile = "./data/AmericanCommunitySurvey.csv")
}

acs <- data.frame(read.csv("./data/AmericanCommunitySurvey.csv"))

strsplit(names(acs),"wgtp")[123]

if (!file.exists("./data/GDP.csv")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  download.file(fileUrl, destfile = "./data/GDP.csv")
}

gdp <- data.frame(read.csv("./data/GDP.csv",skip=5,header=FALSE, nrows=215))
gdp_num <- gsub(",", "", gdp$V5)
mean(as.numeric(gdp_num), na.rm=TRUE)

grep("^United",gdp$V4)

if (!file.exists("./data/Fedstats_country.csv")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  download.file(fileUrl, destfile = "./data/Fedstats_country.csv")
}

fedstats <- data.frame(read.csv("./data/Fedstats_country.csv"))

mergedData = merge(gdp,fedstats,by.x="V1",by.y="CountryCode",all=TRUE)
special.notes <- mergedData[!is.na(mergedData$Special.Notes),]["Special.Notes"]
table(grepl("^Fiscal year end: June", special.notes$Special.Notes))

library(quantmod)
amzn <- getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn)
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
grep("^2012",amzn$row.names)
