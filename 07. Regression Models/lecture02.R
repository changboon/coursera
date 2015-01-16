library(UsingR); data(diamond)
plot(diamond$carat,diamond$price,
     xlab="Mass(carats)",
     ylab="Price(SIN$)",
     bg="lightblue",
     col="black",cex=1.1,pch=21,frame=FALSE)
fit <- lm(price~carat,data=diamond)
abline(fit,lwd=2)
coef(fit)

fit2<-lm(price~I(carat-mean(carat)),data=diamond)
coef(fit2)

fit3<-lm(price~I(carat*10),data=diamond)
coef(fit3)

# first way to predict price based on model
newx<-c(0.16,0.27,0.34)
coef(fit)[1]+coef(fit)[2]*newx
# second way to predict price based on model
predict(fit,newdata=data.frame(carat=newx))

#residuals
data(diamond)
y<-diamond$price;x<-diamond$carat;n<-length(y)
fit<-lm(y~x)
e<-resid(fit)
yhat<-predict(fit)
max(abs(e-(y-yhat)))
