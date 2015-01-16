
2.
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

7.
library(datasets)
library(ggplot2)
data(airquality)
airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)
