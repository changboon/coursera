setwd("~/coursera/03. Obtaining and Cleaning Data/quiz 01")

if (!file.exists("data")) {
  dir.create("data")
}
if (!file.exists("./data/quiz01data.csv")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl, destfile = "./data/quiz01data.csv")
}

quiz01data <- read.csv("./data/quiz01data.csv")

bool_check <- quiz01data$VAL == 24
sum(bool_check, na.rm=TRUE)

if (!file.exists("./data/quiz01xlsx.xlsx")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
  download.file(fileUrl, destfile = "./data/quiz01xlsx.xlsx", mode = "wb")
}

library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./data/quiz01xlsx.xlsx", sheetIndex=1, header=TRUE, rowIndex=rowIndex, colIndex=colIndex)
sum(dat$Zip*dat$Ext,na.rm=T) 

library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)

zipcodes <- xpathSApply(rootNode,"//zipcode",xmlValue)
sum(zipcodes == 21231)

if (!file.exists("./data/idaho.csv")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv "
  download.file(fileUrl, destfile = "./data/idaho.csv")
}

library(data.table)
DT <- data.table(read.csv("./data/idaho.csv"))
