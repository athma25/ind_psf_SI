source('fit_gamma_lib.r');

graphics.off()
set.seed(2)

dat<- read.table("data_01",header=TRUE);
t<- dat$Time
h<- dat$Height;

png(filename="figure2c.png",width=1200, height=400);
#dev.new(width=12, height=4)
par(mar=c(4,6,3,1))
par(mfrow=c(1,3))
plot(t,h,xlab="Time",ylab="Height",cex.lab=4,ylim=c(0,6),col="orange2",pch=16,cex=2,cex.axis=1.5)
nlfit<- nls(h~a+b*t+exp(-2*c*t)*d,start=list(a=1,b=1,c=1,d=1))
lines(t,predict(nlfit));
legend(x=0.5,y=max(h),legend=c("Data","Fit"),lty=c(NA,1),pch=c(1,NA),cex=3);

dat<- read.table("data_02",header=TRUE);
t<- dat$Time
h<- dat$Height;

points(t,h,col="steelblue3",pch=16,cex=2)
nlfit<- nls(h~a+b*t+exp(-2*c*t)*d,start=list(a=1,b=1,c=1,d=1))
lines(t,predict(nlfit));

dat<- read.table("data_h_012",header=TRUE);
t<- dat$Time
h<- dat$Height;

plot(t,h,xlab="Time",ylab="Height",cex.lab=4,col="steelblue3",pch=15,cex=2,cex.axis=1.5)
nlfit<- nls(h~a+b*t+exp(-2*c*t)*d,start=list(a=1,b=1,c=1,d=1))
lines(t,predict(nlfit));

dat<- read.table("data_12",header=TRUE);
t<- dat$Time
h<- dat$Height;

points(t,h,col="steelblue3",pch=17,cex=1.5)
nlfit<- nls(h~a+b*t+exp(-2*c*t)*d,start=list(a=1,b=1,c=1,d=1))
lines(t,predict(nlfit));
legend(x=0.5,y=max(h),legend=c("Half cond.","Fully cond."),pch=c(15,17),col="steelblue3",cex=3);

s<- seq(-1.5,1.5,0.01)
plot(s,(1-s^2/1.2^2),type='l',ylim=c(-0.5,1.2),col="orange2",xlab="Soil condition",ylab="Intrinsic growth rate",cex.lab=4,lwd=2,cex.axis=1.5);
lines(s,1.19*(1-(0.58-s)^2/0.69^2),col="steelblue3",lwd=2);	
lines(s,0*s,lty=3);
lines(c(0,0),c(-2,2),lty=3);
lines(c(0.58,0.58),c(-2,2),lty=3);
points(c(0,0.58),c(1,(1-0.58^2/1.2^2)),col="orange2",pch=16,cex=3);
points(c(0,0.58),c(1.19*(1-0.58^2/0.69^2),1.2),col="steelblue3",pch=16,cex=3);

dev.off();
