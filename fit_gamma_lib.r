# data_gen generates simulated time series of height measurements
# Inputs: soil origin - s0, soil preference - sp, niche width - w, strength of PSF - b, time step - dt, time range -T, file name - fName
# Output: Table with time and height as columns stored in fName
data_gen=function(s0,sp,w,b,dt,T,fName){
	# Initial conditions
	h0<- 1;	# Height

	# Parameters
	c<- 1; 	#	Conditioning rate

	# Data specifications
	sig<- 0.10;			# Variance of additive Guassian noise in height measurements
	
	tc=(s0-sp)^2/(2*c*w^2)-h0/b;	# Time at which the plant dies when PSF is negative
	
	if(b<0 && tc<T){
		t<- seq(0,tc,dt)
 		write(sprintf("Time range truncated for negative PSF"),stdout());
		if(length(t)<10){
			stop("Conditions too extreme");
		}
	} else {
		t<- seq(0,T,dt);	
	}

	h<-h0+b*(t+((-1+exp(-2*c*t))*(s0-sp)^2)/(2*c*w^2))+rnorm(length(t),0,sig);
	write.table(cbind(t,h),fName,row.names=FALSE,col.names=list("Time","Height"));
}

# Non-linear regressions
# data_nlfit_1 finds niche width of species 1
# Input: File name with table of time series data - fName
# Output: Plot of height time series, intrinsic growth rate vs time and vs soil condition
# Note: The origin of the soil axis is set at soil preference of species 1 (0);
#       The scale of the axis is set by the soil origin (-1) 
# 			omega should be sufficiently large otherwise adjust reduce time range and increase resolution
#				For negative beta make sure resolution is sufficienmt
data_nlfit_1=function(fName){
	dat<- read.table(fName,header=TRUE);
	t<- dat$Time
	h<- dat$Height;

#	graphics.off()
	dev.new(width=10, height=5)
	par(mfrow=c(1,2))
	plot(t,h,xlab="Time",ylab="Height",cex.lab=1.3)
	nlfit<- nls(h~a+b*t+exp(-2*c*t)*d,start=list(a=1,b=1,c=1,d=1))
	lines(t,predict(nlfit),col=2);
	legend(x=1,y=max(h),legend=c("Data","Fit"),col=c(1,2),lty=c(NA,1),pch=c(1,NA));

	b<-unname(coef(nlfit)[2]);
	c<-unname(coef(nlfit)[3]);
	d<-unname(coef(nlfit)[4]);

	sgs=sqrt(b/(2*c*d));

	s<- seq(-sgs*1.1,sgs*1.1,0.01);
#	dev.new()
	plot(s,b*(1-s^2/sgs^2),type='l',xlab="Soil condition",ylab="Intrinsic growth rate",cex.lab=1.3);
	lines(s,0*s,lty=3);
	lines(c(0,0),c(-2,2),lty=3);
	mtext("Species 1",side=3,line=-3,outer=TRUE,font=2,cex=2);

	write("Summary of the fit",stdout());
	print(summary(nlfit));
	
	write(sprintf("Niche width is %.2f and strength of feedback is %.2f",sgs,b),stdout());
}

# data_nlfit_2 finds soil preference and niche width of species 2+
# Input: fName1 - heigth data with initial soil s1
#				 fName2 - height data with initial soil s2
#				 fName3 - height data with initial soil (s1+s2)/2; "half life" while conditioning from s1 to s2
# Output: Plot of height time series, intrinsic growth rate vs time (for fName1 and fName2) and vs soil condition

data_nlfit_2=function(fName1,fName2,fName3,s1,s2){
	dat1<- read.table(fName1,header=TRUE);

	t<- dat1$Time
	h<- dat1$Height;

#	graphics.off()
	dev.new(width=10,height=10)
	par(mar=c(5,6,7,3),mfrow=c(2,2))
	plot(t,h,xlab="Time",ylab="Height",cex.lab=1.3)
	nlfit<- nls(h~a+b*t+exp(-2*c*t)*d,start=list(a=-1,b=1,c=1,d=2))
	lines(t,predict(nlfit),col=2);
	legend(x=1,y=max(h),legend=c("Data","Fit"),col=c(1,2),lty=c(NA,1),pch=c(1,NA));
	title("Starting from background soil");

	write("Summary of the first fit",stdout());
	print(summary(nlfit));

	a1=unname(coef(nlfit)[1]);
	b1=unname(coef(nlfit)[2]);
	c1=unname(coef(nlfit)[3]);
	d1=unname(coef(nlfit)[4]);

	dat2<- read.table(fName2,header=TRUE);

	t<- dat2$Time
	h<- dat2$Height;

#	dev.new()
	plot(t,h,xlab="Time",ylab="Height",cex.lab=1.3)
	nlfit<- nls(h~a+b*t+exp(-2*c*t)*d,start=list(a=-1,b=1,c=1,d=2))
	lines(t,predict(nlfit),col=2);
	legend(x=2,y=max(h),legend=c("Data","Fit"),col=c(1,2),lty=c(NA,1),pch=c(1,NA));
	title("... halfway between background and species 1 soil");

	write("Summary of the second fit",stdout());
	print(summary(nlfit));

	a2=unname(coef(nlfit)[1]);
	b2=unname(coef(nlfit)[2]);
	c2=unname(coef(nlfit)[3]);
	d2=unname(coef(nlfit)[4]);

	dat3<- read.table(fName3,header=TRUE);

	t<- dat3$Time
	h<- dat3$Height;

#	dev.new()
	plot(t,h,xlab="Time",ylab="Height",cex.lab=1.3)
	nlfit<- nls(h~a+b*t+exp(-2*c*t)*d,start=list(a=-1,b=1,c=1,d=2))
	lines(t,predict(nlfit),col=2);
	legend(x=2,y=max(h),legend=c("Data","Fit"),col=c(1,2),lty=c(NA,1),pch=c(1,NA));
	title("Starting from species 1 soil");

	write("Summary of the third fit",stdout());
	print(summary(nlfit));

	a3=unname(coef(nlfit)[1]);
	b3=unname(coef(nlfit)[2]);
	c3=unname(coef(nlfit)[3]);
	d3=unname(coef(nlfit)[4]);

	b=(b1+b2+b3)/3;
	c=(c1+c2+c3)/3;

	if(abs(d2)<(abs(d1)+abs(d3))/4){
		write(sprintf("Soil preference is between the two reference soils"),stdout());
		sp=s2-(s2-s1)/(sqrt(d1/d3)+1);
		sgs=(s2-s1)*sqrt(abs(b)/(2*c))/(sqrt(abs(d1))+sqrt(abs(d3)));
	} else{
		if(abs(d1)>abs(d3)){
			write(sprintf("Soil preference is to the right of the two reference soils"),stdout());
			sp=s2+(s2-s1)/(sqrt(d1/d3)-1);
			sgs=(s2-s1)*sqrt(abs(b)/(2*c))/(sqrt(abs(d1))-sqrt(abs(d3)));
		} else{
			write(sprintf("Soil preference is to the left of the two reference soils"),stdout());
			sp=s2+(s2-s1)/(sqrt(d1/d3)-1);
			sgs=(s1-s2)*sqrt(abs(b)/(2*c))/(sqrt(abs(d1))-sqrt(abs(d3)));
		}
	}

	write(sprintf("Soil preference is %.2f, niche width is %.2f and strength of feedback is %.2f",sp,sgs,b),stdout());

	s<- seq(sp-1.1*sgs,sp+1.1*sgs,0.01);

#	dev.new()
	plot(s,b*(1-(sp-s)^2/sgs^2),type='l',xlab="Soil condition",ylab="Intrinsic growth rate",cex.lab=1.3);
	lines(s,0*s,lty=3);
	lines(c(sp,sp),c(-2,2),lty=3);
	mtext("Species 2",side=3,line=-2,outer=TRUE,font=2,cex=2);
}
