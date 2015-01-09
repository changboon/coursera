library(datasets)
data(iris)

head(iris)

x<-iris[iris$Species == "virginica",]

mean(x[,1], na.rm=TRUE)
apply(iris[, 1:4], 2, mean)

library(datasets)
data(mtcars)
head(mtcars)
tapply(mtcars$mpg, mtcars$cyl, mean)

y<-tapply(mtcars$hp, mtcars$cyl, mean)
y[3]-y[1]

