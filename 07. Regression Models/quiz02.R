1.
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
fit<-lm(y~x)
summary(fit) # Pr(>|t|) for X

2.
summary (fit) # Residual standard error

3.
x<-mtcars$wt
y<-mtcars$mpg
fit<-lm(y ~ x)

predict(fit,data.frame(x=mean(x)), interval="confidence")
sumCoef[2,1] + c(-1, 1) * qt(.975, df = fit$df) * sumCoef[2, 2]

4.
?mtcars
summary(fit)
#[, 1]   mpg	 Miles/(US) gallon
#[, 6]	 wt	 Weight (lb/1000)
# mpg ~ wt

5.
predict(fit,data.frame(x=3), interval="prediction")

6.
fit2<-lm(y ~ I(x/2))
sumCoef <- summary(fit2)$coefficients
sumCoef[2,1] + c(-1, 1) * qt(.975, df = fit2$df) * sumCoef[2, 2]

8.
fit <- lm(y~x)
fit3 <- lm(y~1)
anova(fit)
anova(fit3)
# read values from both Sum Sq
278/1126
