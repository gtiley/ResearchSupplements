#Change the working directory to where you have the data and the tree files
#setwd("YOUR_DIR")
library(ggplot2)
library(gridExtra)
library(ape)

#Read in the data as the data frame "dat"
#I then generate a subset without the NA from Ne values because they will cause some problems
dat <- read.table("TableS1.txt",sep="\t",header=TRUE)
good <- complete.cases(dat)
dat2 <- dat[good,]

########################################
#Regression analyses for raw values
########################################

#Generate Panel a
lmres <- lm(Mutation.Rate ~ log(Ne,base=10),data=dat2)
civalues <- seq(10000,2000000,by = 100)
conf_interval <- predict(lmres, newdata=data.frame(Ne=civalues), interval="confidence",level=0.95)
dft1 <- data.frame(x = civalues, y=conf_interval[,2])
dft2 <- data.frame(x = civalues, y=conf_interval[,3])
p1 <- ggplot(dat, aes(x=Ne, y=Mutation.Rate, color=factor(Category))) + scale_color_manual(values=c("#393E41","#E2C044","#3626A7","#035E7B","#A44A3F")) + geom_point(size = 3) + scale_x_continuous(name=expression(paste(italic("N"[e]) %*% 10^3,sep="")),breaks=c(10000,100000,1000000),labels=c("10","100","1000"),trans="log10") + scale_y_continuous(name=expression(paste(mu %*% 10^-8,sep="")),breaks=c(0.000000004,0.000000008,0.000000012,0.000000016),labels=c("0.4","0.8","1.2","1.6")) + theme_bw() + theme(legend.position="none",legend.title=element_blank(),legend.text=element_text(size=6)) + geom_abline(slope = coef(lmres)[[2]], intercept = coef(lmres)[[1]], col="black") + geom_line(data=dft1,aes(x=x, y=y), col="black",linetype="dotted") + geom_line(data=dft2,aes(x=x, y=y), col="black",linetype="dotted")

#Generate Panel b - I do not bother estimating the CI for very small values, the lower limit is 1 gram
lmres <- lm(Mutation.Rate ~ log(Mass,base=10),data=dat)
civalues <- seq(1,600000,by = 1)
conf_interval <- predict(lmres, newdata=data.frame(Mass=civalues), interval="confidence",level=0.95)
dft1 <- data.frame(x = civalues, y=conf_interval[,2])
dft2 <- data.frame(x = civalues, y=conf_interval[,3])
p2 <- ggplot(dat, aes(x=Mass, y=Mutation.Rate, color=factor(Category))) + scale_color_manual(values=c("#393E41","#E2C044","#3626A7","#035E7B","#A44A3F")) + geom_point(size = 3) + scale_x_continuous(name=expression(paste("Mass (grams)" %*% 10^3,sep="")),breaks=c(0,1,10,100,1000,10000,100000),labels=c("0","0.001","0.01","0.1","1","10","100"),trans="log10") + scale_y_continuous(name=expression(paste("",sep="")),breaks=c(0.000000004,0.000000008,0.000000012,0.000000016),labels=c("0.4","0.8","1.2","1.6")) + theme_bw() + theme(legend.position="none",legend.title=element_blank(),legend.text=element_text(size=6)) + geom_abline(slope = coef(lmres)[[2]], intercept = coef(lmres)[[1]], col="black") + geom_line(data=dft1,aes(x=x, y=y), col="black",linetype="dotted") + geom_line(data=dft2,aes(x=x, y=y), col="black",linetype="dotted")

########################################
#Regression analyses PICs
########################################

#Here are two trees used to calculate PICs
#All branch lengths are set to 1
t1 <- read.tree("fig3phylogeny1.tre")
t2 <- read.tree("fig3phylogeny2.tre")

#Generate Panel c
ne <- log(dat2$Ne, base=10)
names(ne) <- dat2$Species
mu1 <- dat2$Mutation.Rate
names(mu1) <- dat2$Species

ne.pic <- pic(ne,t1)
mu1.pic <- pic(mu1,t1)

dfpic1 <- data.frame(x = ne.pic, y=mu1.pic)
lmres <- lm(y ~ x,data=dfpic1)
civalues <- seq(min(ne.pic),max(ne.pic),by = 0.01)
conf_interval <- predict(lmres, newdata=data.frame(x=civalues), interval="confidence",level=0.95)
dft1 <- data.frame(x = civalues, y=conf_interval[,2])
dft2 <- data.frame(x = civalues, y=conf_interval[,3])
p3 <- ggplot(dfpic1, aes(x=x, y=y)) + geom_point(size = 3) + scale_x_continuous(name=expression(paste("PIC ",italic("N"[e]),sep="")),breaks=c(-0.6,-0.4,-0.2,0,0.2,0.4,0.6),labels=c("-0.6","-0.4","-0.2","0","0.2","0.4","0.6")) + scale_y_continuous(name=expression(paste("PIC ",mu %*% 10^-9,sep="")),breaks=c(-0.000000006,-0.000000004,-0.000000002,0,0.000000002,0.000000004),labels=c("-6","-4","-2","0","2","4")) + theme_bw() + theme(legend.position="none",legend.title=element_blank(),legend.text=element_text(size=6)) + geom_abline(slope = coef(lmres)[[2]], intercept = coef(lmres)[[1]], col="black") + geom_line(data=dft1,aes(x=x, y=y), col="black",linetype="dotted") + geom_line(data=dft2,aes(x=x, y=y), col="black",linetype="dotted")

#Generate Panel d
ma <- log(dat$Mass, base=10)
names(ma) <- dat$Species
mu2 <- dat$Mutation.Rate
names(mu2) <- dat$Species

ma.pic <- pic(ma,t2)
mu2.pic <- pic(mu2,t2)

dfpic2 <- data.frame(x = ma.pic, y=mu2.pic)
lmres <- lm(y ~ x,data=dfpic2)
civalues <- seq(min(ma.pic),max(ma.pic),by = 0.1)
conf_interval <- predict(lmres, newdata=data.frame(x=civalues), interval="confidence",level=0.95)
dft1 <- data.frame(x = civalues, y=conf_interval[,2])
dft2 <- data.frame(x = civalues, y=conf_interval[,3])
p4 <- ggplot(dfpic2, aes(x=x, y=y)) + geom_point(size = 3) + scale_x_continuous(name=expression(paste("PIC Mass")),breaks=c(-2,-1,0,1,2),labels=c("-2","-1","0","1","2")) + scale_y_continuous(name=expression(paste("",sep="")),breaks=c(-0.000000006,-0.000000004,-0.000000002,0,0.000000002,0.000000004),labels=c("-6","-4","-2","0","2","4")) + theme_bw() + theme(legend.position="none",legend.title=element_blank(),legend.text=element_text(size=6)) + geom_abline(slope = coef(lmres)[[2]], intercept = coef(lmres)[[1]], col="black") + geom_line(data=dft1,aes(x=x, y=y), col="black",linetype="dotted") + geom_line(data=dft2,aes(x=x, y=y), col="black",linetype="dotted")

#Arrange the plots with gridExtra - I set useDingbats to False so I bring the pdf into illustrator to add panel labels and the regression results
g1 <- grid.arrange(p1,p2,p3,p4, nrow=2)
ggsave("Fig3.pdf",g1,width=6.5,height=6,device="pdf",useDingbats=FALSE)