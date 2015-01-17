library(UsingR)
data(galton)
par(mfrow=c(1,2))
hist(galton$child,col="blue",breaks=100)
hist(galton$parent,col="blue",breaks=100)

library(manipulate)
myHist<-function(mu){
  hist(galton$child,col="blue",breaks=100)
  lines(c(mu,mu),c(0,150),col="red",lwd=5)
  mse<-mean((galton$child-mu)^2)
  text(63,150,paste("mu=",mu))
  text(63,140,paste("MSE=",round(mse,2)))
}
manipulate(myHist(mu),mu=slider(62,74,step=0.5))

hist(galton$child,col="blue",breaks=100)
meanChild<-mean(galton$child)
lines(rep(meanChild,100),seq(0,150,length=100),col="red",lwd=5)

plot(galton$parent,galton$child,pch=19,col="blue")

myPlot<-function(beta){
  y<-galton$child-mean(galton$child)
  x<-galton$parent-mean(galton$parent)
  freqData<-as.data.frame(table(x,y))
  names(freqData)<-c("child","parent","freq")
  plot(
    as.numeric(as.vector(freqData$parent)),
    as.numeric(as.vector(freqData$child)),
    pch=21,col="black",bg="lightblue",
    cex=.15*freqData$freq,
    xlab="parent",
    ylab="child"
  )
  abline(0,beta,lwd=3)
  points(0,0,cex=2,pch=19)
  mse<-mean((y-beta*x)^2)
  title(paste("beta=",beta,"mse=",round(mse,3)))
}
manipulate(myPlot(beta),beta=slider(0.6,1.2,step=0.02))

lm(I(child-mean(child))~I(parent-mean(parent))-1,data=galton)

#find intercept and gradient
y<-galton$child
x<-galton$parent
beta1<-cor(y,x)* sd(y)/sd(x)
beta0<-mean(y)-beta1*mean(x)
rbind(c(beta0,beta1),coef(lm(y~x)))

#reversing the outcome/predictor relationship
beta1<-cor(y,x)* sd(x)/sd(y)
beta0<-mean(x)-beta1*mean(y)
rbind(c(beta0,beta1),coef(lm(x~y)))

#regression through origin after centering the data
yc<-y-mean(y)
xc<-x-mean(x)
beta1<-sum(yc*xc)/sum(xc^2)
c(beta1,coef(lm(y~x))[2])

#normalising variables result in slope being correlation
yn<-(y-mean(y))/sd(y)
xn<-(x-mean(x))/sd(x)
c(cor(y,x),cor(yn,xn),coef(lm(yn~xn))[2])

#regression to the mean
library(UsingR)
data(father.son)
y<-(father.son$sheight-mean(father.son$sheight))/sd(father.son$sheight)
x<-(father.son$fheight-mean(father.son$fheight))/sd(father.son$fheight)
rho<-cor(x,y)
myPlot<-function(x,y){
  plot(x,y,
       xlab="Father'sheight,normalized",
       ylab="Son'sheight,normalized",
       xlim=c(-3,3),ylim=c(-3,3),
       bg="lightblue",col="black",cex=1.1,pch=21,
       frame=FALSE)
}
myPlot(x,y)
abline(0,1)#iftherewereperfectcorrelation
abline(0,rho,lwd=2)#fatherpredictsson
abline(0,1/rho,lwd=2)#sonpredictsfather,sononverticalaxis
abline(h=0);abline(v=0)#referencelinesfornorelathionship

