setwd("~/coursera/03. Obtaining and Cleaning Data/quiz 03")
if (!file.exists("data")) {
  dir.create("data")
}
if (!file.exists("./data/AmericanCommunitySurvey.csv")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl, destfile = "./data/AmericanCommunitySurvey.csv")
}

acs <- data.frame(read.csv("./data/AmericanCommunitySurvey.csv"))
agricultureLogical <- acs$ACR == 3 & acs$AGS == 6 
which(agricultureLogical)

library(jpeg)
if (!file.exists("./data/getdata%2Fjeff.jpg")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
  download.file(fileUrl, destfile = "./data/getdata%2Fjeff.jpg", mode="wb")
}
jpg <- readJPEG("./data/getdata%2Fjeff.jpg", native=TRUE) 
quantile(jpg,probs=c(0.3,0.8))

if (!file.exists("./data/GDP.csv")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  download.file(fileUrl, destfile = "./data/GDP.csv")
}

if (!file.exists("./data/Fedstats_country.csv")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  download.file(fileUrl, destfile = "./data/Fedstats_country.csv")
}

gdp <- data.frame(read.csv("./data/GDP.csv",skip=5,header=FALSE, nrows=215))
fedstats <- data.frame(read.csv("./data/Fedstats_country.csv"))
head(gdp,1)
head(fedstats,1)

gdp[,1]
mergedData = merge(gdp,fedstats,by.x="V1",by.y="CountryCode",all=TRUE)
mergedData <- mergedData[!is.na(mergedData$V4),]
mergedData <- mergedData[!is.na(mergedData$V2),]
mergedData <- mergedData[order(-mergedData$V2),]
sum(is.na(mergedData$V4))
mergedData[13,4]

highIncomeOECD <- mergedData[mergedData$Income.Group == "High income: OECD",]
mean(highIncomeOECD$V2,na.rm=TRUE)
highIncomeNonOECD <- mergedData[mergedData$Income.Group == "High income: nonOECD",]
mean(highIncomeNonOECD$V2,na.rm=TRUE)

library(Hmisc)
mergedData$GDPGroups = cut2(mergedData$V2,g=5)
table(mergedData$GDPGroups, mergedData$Income.Group)
