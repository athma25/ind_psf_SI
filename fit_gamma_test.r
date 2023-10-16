source('fit_gamma_lib.r');

# Known issues: Method does not work when reference soil and soil preference are too close to each other or niche width is too wide

graphics.off()
set.seed(1)

# Parameters 
# Soil origin = -1, preference of species 1 = 0
b1<- 1;		# Strengh of feedback in species 1
w1<- 1;		# Niche width of species 1

s2<- 0.75;	  # Preference of species 2
b2<- 1.2;		# Strengh of feedback in species 2
w2<- 1;		# Niche width of species 2

dt=0.2;	# Time step
T=5;			# Time range

# Simulate data
data_gen(-1,0,w1,b1,dt,T,"data_01");
data_gen(-1,s2,w2,b2,dt,T,"data_02");
data_gen(-0.5,s2,w2,b2,dt,T,"data_h_012");
data_gen(0,s2,w2,b2,dt,T,"data_12");

# Find b1 and w1
data_nlfit_1("data_01");

# Find s2 and w2
data_nlfit_2("data_02","data_h_012","data_12",-1,0);

# Interaction coefficient
data_gen(0,0,w1,b1,dt,T,"data_11");
data_gen(s2,0,w1,b1,dt,T,"data_12");
data_gen(0,s2,w2,b2,dt,T,"data_21");
data_gen(s2,s2,w2,b2,dt,T,"data_22");

dat11<-read.table("data_11",header=TRUE)$Height;
dat12<-read.table("data_12",header=TRUE)$Height;
dat21<-read.table("data_21",header=TRUE)$Height;
dat22<-read.table("data_22",header=TRUE)$Height;

Is_est=(tail(dat11,1)-tail(dat12,1)+tail(dat22,1)-tail(dat21,1))/T;
Is=b1-b1*(1-s2^2/w1^2)+b2-b2*(1-s2^2/w2^2);
write(sprintf("Estimated interaction coefficient (from time series) is %.2f, actual interaction coefficient is %.2f",Is_est,Is),stdout());
