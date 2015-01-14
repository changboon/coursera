setwd("~/coursera/04. Exploratory Analysis")

pollution <- read.csv("data/avgpm25.csv", 
                      colClasses = c("numeric", "character", 
                      "factor", "numeric", "numeric"))
head(pollution)

# 5 simple summary for 1 dimension data
summary(pollution$pm25)

boxplot(pollution$pm25, col = "blue")

hist(pollution$pm25, col = "green")

hist(pollution$pm25, col = "green")
rug(pollution$pm25)
hist(pollution$pm25, col = "green", breaks = 100)
rug(pollution$pm25)

boxplot(pollution$pm25, col = "blue")
abline(h = 12)

hist(pollution$pm25, col = "green")
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)

barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")
