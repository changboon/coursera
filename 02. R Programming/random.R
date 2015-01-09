library(ggplot2)
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

install.packages("KernSmooth")
library(KernSmooth)

install.packages("devtools")
library(devtools)
find_rtools()

x<-c(4, TRUE)
class(x)
x <- list(2, "a", "b", TRUE)
x[[2]]
x[2]

x<-1:4
y<-2:3
x+y

x <- c(3, 5, 1, 10, 12, 6) 
x[x<6]<- 0
x

csv <- read.csv("hw1_data.csv")
names(csv)
head(csv, 2)
row(csv)
tail(csv,2)
csv[47,]
sum(is.na(csv[,1]))
mean(as.numeric(csv[,1]), na.rm=TRUE)
ozone <- csv[,1] > 31
temp <- csv[,4] > 90
print(ozone)
print(temp)
bool <- ozone*temp
bool[is.na(bool)]<-FALSE
print(bool)
result <- csv[,2][ozone & temp]
mean(result, na.rm=TRUE)

head(csv,1)
mean(csv[,4][csv[,5]==6])

max(csv[,1][csv[,5]==5], na.rm=TRUE)

install_from_swirl("R Programming")
