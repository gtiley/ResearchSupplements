setwd("~/Campbell_et_al_2020/divtime/")
library(coda)
for (i in 0:0)
{

	dat_chain1 <- read.table(paste(i,".0/samp.",i,".0.log",sep=""),header=TRUE,sep="\t")
	dat_chain2 <- read.table(paste(i,".1/samp.",i,".1.log",sep=""),header=TRUE,sep="\t")
	
	png(paste(i,".posteriorRates.png",sep=""),res=300,height=10*300,width=8*300)
	par(mfrow=c(9,6),mar=c(2,2,1,1),oma=c(3,3,1,1))

################################################################
####GROUP 1
################################################################

hist(dat_chain1$r00,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r00,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext(expression(paste(mu["a"])),side=3,line=0.5,cex=1.2)
mtext("Group 1",side=2,line=2)

hist(dat_chain1$r01,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r01,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext(expression(paste(mu["b"])),side=3,line=0.5,cex=1.2)

hist(dat_chain1$r02,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r02,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext(expression(paste(mu["c"])),side=3,line=0.5,cex=1.2)

hist(dat_chain1$r03,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r03,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext(expression(paste(mu["d"])),side=3,line=0.5,cex=1.2)

hist(dat_chain1$r04,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r04,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext(expression(paste(mu["e"])),side=3,line=0.5,cex=1.2)

hist(dat_chain1$r05,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r05,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext(expression(paste(mu["f"])),side=3,line=0.5,cex=1.2)

################################################################


################################################################
####GROUP 2
################################################################

hist(dat_chain1$r10,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r10,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext("Group 2",side=2,line=2)

hist(dat_chain1$r11,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r11,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r12,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r12,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r13,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r13,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r14,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r14,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r15,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r15,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)


################################################################


################################################################
####GROUP 3
################################################################


hist(dat_chain1$r20,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r20,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext("Group 3",side=2,line=2)

hist(dat_chain1$r21,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r21,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r22,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r22,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r23,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r23,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r24,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r24,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r25,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r25,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)


################################################################


################################################################
####GROUP 4
################################################################

hist(dat_chain1$r30,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r30,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext("Group 4",side=2,line=2)

hist(dat_chain1$r31,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r31,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r32,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r32,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r33,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r33,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r34,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r34,xlim=c(0,0.0006),ylim=c(0,3000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r35,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r35,xlim=c(0,0.0006),ylim=c(0,4000),breaks=seq(0,0.0006,by=0.00002),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)


################################################################

################################################################
####GROUP 5
################################################################

hist(dat_chain1$r40,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r40,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext("Group 5",side=2,line=2)

hist(dat_chain1$r41,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r41,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r42,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r42,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r43,xlim=c(0,0.002),ylim=c(0,4000),breaks=seq(0,0.002,by=0.00005),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r43,xlim=c(0,0.002),ylim=c(0,4000),breaks=seq(0,0.002,by=0.00005),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r44,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r44,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r45,xlim=c(0,0.002),ylim=c(0,4000),breaks=seq(0,0.002,by=0.00005),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r45,xlim=c(0,0.002),ylim=c(0,4000),breaks=seq(0,0.002,by=0.00005),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)


################################################################


################################################################
####GROUP 6
################################################################

hist(dat_chain1$r50,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r50,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext("Group 6",side=2,line=2)

hist(dat_chain1$r51,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r51,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r52,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r52,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r53,xlim=c(0,0.002),ylim=c(0,4000),breaks=seq(0,0.002,by=0.00005),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r53,xlim=c(0,0.002),ylim=c(0,4000),breaks=seq(0,0.002,by=0.00005),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r54,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r54,xlim=c(0,0.002),ylim=c(0,3000),breaks=seq(0,0.002,by=0.00005),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r55,xlim=c(0,0.002),ylim=c(0,4000),breaks=seq(0,0.002,by=0.00005),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r55,xlim=c(0,0.002),ylim=c(0,4000),breaks=seq(0,0.002,by=0.00005),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)


################################################################


################################################################
####GROUP 7
################################################################

hist(dat_chain1$r60,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r60,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext("Group 7",side=2,line=2)

hist(dat_chain1$r61,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r61,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r62,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r62,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r63,xlim=c(0,0.001),ylim=c(0,4000),breaks=seq(0,0.002,by=0.000025),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r63,xlim=c(0,0.001),ylim=c(0,4000),breaks=seq(0,0.002,by=0.000025),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r64,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r64,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r65,xlim=c(0,0.001),ylim=c(0,4000),breaks=seq(0,0.002,by=0.000025),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r65,xlim=c(0,0.001),ylim=c(0,4000),breaks=seq(0,0.002,by=0.000025),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)


################################################################

################################################################
####GROUP 8
################################################################

hist(dat_chain1$r70,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r70,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext("Group 8",side=2,line=2)

hist(dat_chain1$r71,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r71,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r72,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r72,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r73,xlim=c(0,0.001),ylim=c(0,4000),breaks=seq(0,0.002,by=0.000025),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r73,xlim=c(0,0.001),ylim=c(0,4000),breaks=seq(0,0.002,by=0.000025),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r74,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r74,xlim=c(0,0.001),ylim=c(0,3000),breaks=seq(0,0.002,by=0.000025),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r75,xlim=c(0,0.001),ylim=c(0,4000),breaks=seq(0,0.002,by=0.000025),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r75,xlim=c(0,0.001),ylim=c(0,4000),breaks=seq(0,0.002,by=0.000025),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)


################################################################

################################################################
####GROUP 9
################################################################

hist(dat_chain1$r80,xlim=c(0,0.0036),ylim=c(0,3000),breaks=seq(0,0.0036,by=0.0001),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r80,xlim=c(0,0.0036),ylim=c(0,3000),breaks=seq(0,0.0036,by=0.0001),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)
mtext("Group 9",side=2,line=2)

hist(dat_chain1$r81,xlim=c(0,0.0036),ylim=c(0,3000),breaks=seq(0,0.0036,by=0.00012),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r81,xlim=c(0,0.0036),ylim=c(0,3000),breaks=seq(0,0.0036,by=0.00012),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r82,xlim=c(0,0.0036),ylim=c(0,3000),breaks=seq(0,0.0036,by=0.00012),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r82,xlim=c(0,0.0036),ylim=c(0,3000),breaks=seq(0,0.0036,by=0.00012),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r83,xlim=c(0,0.0036),ylim=c(0,4000),breaks=seq(0,0.0036,by=0.00012),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r83,xlim=c(0,0.0036),ylim=c(0,4000),breaks=seq(0,0.0036,by=0.00012),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r84,xlim=c(0,0.0036),ylim=c(0,3000),breaks=seq(0,0.0036,by=0.00012),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r84,xlim=c(0,0.0036),ylim=c(0,3000),breaks=seq(0,0.0036,by=0.00012),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)

hist(dat_chain1$r85,xlim=c(0,0.0036),ylim=c(0,4000),breaks=seq(0,0.0036,by=0.00012),col=rgb(1,0,0,0.5),xlab="",ylab="",main="")
hist(dat_chain2$r85,xlim=c(0,0.0036),ylim=c(0,4000),breaks=seq(0,0.0036,by=0.00012),col=rgb(0,0,1,0.5),xlab="",ylab="",main="",add=TRUE)


################################################################
################################################################
#Closing Plate
################################################################
################################################################
mtext("Frequency",side=2,line=1.5,outer=TRUE)
mtext(expression(paste("Absolute Rate of Evolution (x10"^-8,")")),side=1,line=1.0,cex=1.0,outer=TRUE)
dev.off()
}

################################################################

write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Hsap.meanRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Ptro.meanRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Pabe.meanRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Csab.meanRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Cjac.meanRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Mmur.meanRates.txt",sep=""))

write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Hsap.upperRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Ptro.upperRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Pabe.upperRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Csab.upperRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Cjac.upperRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Mmur.upperRates.txt",sep=""))

write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Hsap.lowerRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Ptro.lowerRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Pabe.lowerRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Csab.lowerRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Cjac.lowerRates.txt",sep=""))
write(paste("Replicate\tGroup1\tGroup2\tGroup3\tGroup4\tGroup5\tGroup6\tGroup7\tGroup8\Group9")file=paste("Mmur.lowerRates.txt",sep=""))

################################################################
####RATE DISTRIBUTIONS AMONG GROUPS
################################################################
for (i in 0:0)
{

	dat_chain1 <- read.table(paste(i,".0/samp.",i,".0.log",sep=""),header=TRUE,sep="\t")
	dat_chain1 <- read.table(paste(i,".1/samp.",i,".1.log",sep=""),header=TRUE,sep="\t")
	########
	png(paste(i,".rateDistributions.png",sep=""),res=300,height=10*300,width=8*300)
	par(mfrow=c(3,3),mar=c(2,2,1,1),oma=c(4,4,1,1))

	rates <- c()
	ratelowerHPD <- c()
	rateupperHPD <- c()


r00 <- c(dat_chain1$r00,dat_chain2$r00)
r01 <- c(dat_chain1$r01,dat_chain2$r01)
r02 <- c(dat_chain1$r02,dat_chain2$r02)
r03 <- c(dat_chain1$r03,dat_chain2$r03)
r04 <- c(dat_chain1$r04,dat_chain2$r04)
r05 <- c(dat_chain1$r05,dat_chain2$r05)
r10 <- c(dat_chain1$r10,dat_chain2$r10)
r11 <- c(dat_chain1$r11,dat_chain2$r11)
r12 <- c(dat_chain1$r12,dat_chain2$r12)
r13 <- c(dat_chain1$r13,dat_chain2$r13)
r14 <- c(dat_chain1$r14,dat_chain2$r14)
r15 <- c(dat_chain1$r15,dat_chain2$r15)
r20 <- c(dat_chain1$r20,dat_chain2$r20)
r21 <- c(dat_chain1$r21,dat_chain2$r21)
r22 <- c(dat_chain1$r22,dat_chain2$r22)
r23 <- c(dat_chain1$r23,dat_chain2$r23)
r24 <- c(dat_chain1$r24,dat_chain2$r24)
r25 <- c(dat_chain1$r25,dat_chain2$r25)
r30 <- c(dat_chain1$r30,dat_chain2$r30)
r31 <- c(dat_chain1$r31,dat_chain2$r31)
r32 <- c(dat_chain1$r32,dat_chain2$r32)
r33 <- c(dat_chain1$r33,dat_chain2$r33)
r34 <- c(dat_chain1$r34,dat_chain2$r34)
r35 <- c(dat_chain1$r35,dat_chain2$r35)
r40 <- c(dat_chain1$r40,dat_chain2$r40)
r41 <- c(dat_chain1$r41,dat_chain2$r41)
r42 <- c(dat_chain1$r42,dat_chain2$r42)
r43 <- c(dat_chain1$r43,dat_chain2$r43)
r44 <- c(dat_chain1$r44,dat_chain2$r44)
r45 <- c(dat_chain1$r45,dat_chain2$r45)
r50 <- c(dat_chain1$r50,dat_chain2$r50)
r51 <- c(dat_chain1$r51,dat_chain2$r51)
r52 <- c(dat_chain1$r52,dat_chain2$r52)
r53 <- c(dat_chain1$r53,dat_chain2$r53)
r54 <- c(dat_chain1$r54,dat_chain2$r54)
r55 <- c(dat_chain1$r55,dat_chain2$r55)
r60 <- c(dat_chain1$r60,dat_chain2$r60)
r61 <- c(dat_chain1$r61,dat_chain2$r61)
r62 <- c(dat_chain1$r62,dat_chain2$r62)
r63 <- c(dat_chain1$r63,dat_chain2$r63)
r64 <- c(dat_chain1$r64,dat_chain2$r64)
r65 <- c(dat_chain1$r65,dat_chain2$r65)
r70 <- c(dat_chain1$r70,dat_chain2$r70)
r71 <- c(dat_chain1$r71,dat_chain2$r71)
r72 <- c(dat_chain1$r72,dat_chain2$r72)
r73 <- c(dat_chain1$r73,dat_chain2$r73)
r74 <- c(dat_chain1$r74,dat_chain2$r74)
r75 <- c(dat_chain1$r75,dat_chain2$r75)
r80 <- c(dat_chain1$r80,dat_chain2$r80)
r81 <- c(dat_chain1$r81,dat_chain2$r81)
r82 <- c(dat_chain1$r82,dat_chain2$r82)
r83 <- c(dat_chain1$r83,dat_chain2$r83)
r84 <- c(dat_chain1$r84,dat_chain2$r84)
r85 <- c(dat_chain1$r85,dat_chain2$r85)



rates[1] <- mean(r00)
rates[2] <- mean(r01)
rates[3] <- mean(r02)
rates[4] <- mean(r03)
rates[5] <- mean(r04)
rates[6] <- mean(r05)
rates[7] <- mean(r10)
rates[8] <- mean(r11)
rates[9] <- mean(r12)
rates[10] <- mean(r13)
rates[11] <- mean(r14)
rates[12] <- mean(r15)
rates[13] <- mean(r20)
rates[14] <- mean(r21)
rates[15] <- mean(r22)
rates[16] <- mean(r23)
rates[17] <- mean(r24)
rates[18] <- mean(r25)
rates[19] <- mean(r30)
rates[20] <- mean(r31)
rates[21] <- mean(r32)
rates[22] <- mean(r33)
rates[23] <- mean(r34)
rates[24] <- mean(r35)
rates[25] <- mean(r40)
rates[26] <- mean(r41)
rates[27] <- mean(r42)
rates[28] <- mean(r43)
rates[29] <- mean(r44)
rates[30] <- mean(r45)
rates[31] <- mean(r50)
rates[32] <- mean(r51)
rates[33] <- mean(r52)
rates[34] <- mean(r53)
rates[35] <- mean(r54)
rates[36] <- mean(r55)
rates[37] <- mean(r60)
rates[38] <- mean(r61)
rates[39] <- mean(r62)
rates[40] <- mean(r63)
rates[41] <- mean(r64)
rates[42] <- mean(r65)
rates[43] <- mean(r70)
rates[44] <- mean(r71)
rates[45] <- mean(r72)
rates[46] <- mean(r73)
rates[47] <- mean(r74)
rates[48] <- mean(r75)
rates[49] <- mean(r80)
rates[50] <- mean(r81)
rates[51] <- mean(r82)
rates[52] <- mean(r83)
rates[53] <- mean(r84)
rates[54] <- mean(r85)


hpd00 <- HPDinterval(mcmc(r00),prob=0.95)
hpd01 <- HPDinterval(mcmc(r01),prob=0.95)
hpd02 <- HPDinterval(mcmc(r02),prob=0.95)
hpd03 <- HPDinterval(mcmc(r03),prob=0.95)
hpd04 <- HPDinterval(mcmc(r04),prob=0.95)
hpd05 <- HPDinterval(mcmc(r05),prob=0.95)
hpd10 <- HPDinterval(mcmc(r10),prob=0.95)
hpd11 <- HPDinterval(mcmc(r11),prob=0.95)
hpd12 <- HPDinterval(mcmc(r12),prob=0.95)
hpd13 <- HPDinterval(mcmc(r13),prob=0.95)
hpd14 <- HPDinterval(mcmc(r14),prob=0.95)
hpd15 <- HPDinterval(mcmc(r15),prob=0.95)
hpd20 <- HPDinterval(mcmc(r20),prob=0.95)
hpd21 <- HPDinterval(mcmc(r21),prob=0.95)
hpd22 <- HPDinterval(mcmc(r22),prob=0.95)
hpd23 <- HPDinterval(mcmc(r23),prob=0.95)
hpd24 <- HPDinterval(mcmc(r24),prob=0.95)
hpd25 <- HPDinterval(mcmc(r25),prob=0.95)
hpd30 <- HPDinterval(mcmc(r30),prob=0.95)
hpd31 <- HPDinterval(mcmc(r31),prob=0.95)
hpd32 <- HPDinterval(mcmc(r32),prob=0.95)
hpd33 <- HPDinterval(mcmc(r33),prob=0.95)
hpd34 <- HPDinterval(mcmc(r34),prob=0.95)
hpd35 <- HPDinterval(mcmc(r35),prob=0.95)
hpd40 <- HPDinterval(mcmc(r40),prob=0.95)
hpd41 <- HPDinterval(mcmc(r41),prob=0.95)
hpd42 <- HPDinterval(mcmc(r42),prob=0.95)
hpd43 <- HPDinterval(mcmc(r43),prob=0.95)
hpd44 <- HPDinterval(mcmc(r44),prob=0.95)
hpd45 <- HPDinterval(mcmc(r45),prob=0.95)
hpd50 <- HPDinterval(mcmc(r50),prob=0.95)
hpd51 <- HPDinterval(mcmc(r51),prob=0.95)
hpd52 <- HPDinterval(mcmc(r52),prob=0.95)
hpd53 <- HPDinterval(mcmc(r53),prob=0.95)
hpd54 <- HPDinterval(mcmc(r54),prob=0.95)
hpd55 <- HPDinterval(mcmc(r55),prob=0.95)
hpd60 <- HPDinterval(mcmc(r60),prob=0.95)
hpd61 <- HPDinterval(mcmc(r61),prob=0.95)
hpd62 <- HPDinterval(mcmc(r62),prob=0.95)
hpd63 <- HPDinterval(mcmc(r63),prob=0.95)
hpd64 <- HPDinterval(mcmc(r64),prob=0.95)
hpd65 <- HPDinterval(mcmc(r65),prob=0.95)
hpd70 <- HPDinterval(mcmc(r70),prob=0.95)
hpd71 <- HPDinterval(mcmc(r71),prob=0.95)
hpd72 <- HPDinterval(mcmc(r72),prob=0.95)
hpd73 <- HPDinterval(mcmc(r73),prob=0.95)
hpd74 <- HPDinterval(mcmc(r74),prob=0.95)
hpd75 <- HPDinterval(mcmc(r75),prob=0.95)
hpd80 <- HPDinterval(mcmc(r80),prob=0.95)
hpd81 <- HPDinterval(mcmc(r81),prob=0.95)
hpd82 <- HPDinterval(mcmc(r82),prob=0.95)
hpd83 <- HPDinterval(mcmc(r83),prob=0.95)
hpd84 <- HPDinterval(mcmc(r84),prob=0.95)
hpd85 <- HPDinterval(mcmc(r85),prob=0.95)

ratelowerHPD[1] <- hpd00[1]
ratelowerHPD[2] <- hpd01[1]
ratelowerHPD[3] <- hpd02[1]
ratelowerHPD[4] <- hpd03[1]
ratelowerHPD[5] <- hpd04[1]
ratelowerHPD[6] <- hpd05[1]
ratelowerHPD[7] <- hpd10[1]
ratelowerHPD[8] <- hpd11[1]
ratelowerHPD[9] <- hpd12[1]
ratelowerHPD[10] <- hpd13[1]
ratelowerHPD[11] <- hpd14[1]
ratelowerHPD[12] <- hpd15[1]
ratelowerHPD[13] <- hpd20[1]
ratelowerHPD[14] <- hpd21[1]
ratelowerHPD[15] <- hpd22[1]
ratelowerHPD[16] <- hpd23[1]
ratelowerHPD[17] <- hpd24[1]
ratelowerHPD[18] <- hpd25[1]
ratelowerHPD[19] <- hpd30[1]
ratelowerHPD[20] <- hpd31[1]
ratelowerHPD[21] <- hpd32[1]
ratelowerHPD[22] <- hpd33[1]
ratelowerHPD[23] <- hpd34[1]
ratelowerHPD[24] <- hpd35[1]
ratelowerHPD[25] <- hpd40[1]
ratelowerHPD[26] <- hpd41[1]
ratelowerHPD[27] <- hpd42[1]
ratelowerHPD[28] <- hpd43[1]
ratelowerHPD[29] <- hpd44[1]
ratelowerHPD[30] <- hpd45[1]
ratelowerHPD[31] <- hpd50[1]
ratelowerHPD[32] <- hpd51[1]
ratelowerHPD[33] <- hpd52[1]
ratelowerHPD[34] <- hpd53[1]
ratelowerHPD[35] <- hpd54[1]
ratelowerHPD[36] <- hpd55[1]
ratelowerHPD[37] <- hpd60[1]
ratelowerHPD[38] <- hpd61[1]
ratelowerHPD[39] <- hpd62[1]
ratelowerHPD[40] <- hpd63[1]
ratelowerHPD[41] <- hpd64[1]
ratelowerHPD[42] <- hpd65[1]
ratelowerHPD[43] <- hpd70[1]
ratelowerHPD[44] <- hpd71[1]
ratelowerHPD[45] <- hpd72[1]
ratelowerHPD[46] <- hpd73[1]
ratelowerHPD[47] <- hpd74[1]
ratelowerHPD[48] <- hpd75[1]
ratelowerHPD[49] <- hpd80[1]
ratelowerHPD[50] <- hpd81[1]
ratelowerHPD[51] <- hpd82[1]
ratelowerHPD[52] <- hpd83[1]
ratelowerHPD[53] <- hpd84[1]
ratelowerHPD[54] <- hpd85[1]


rateupperHPD[1] <- hpd00[2]
rateupperHPD[2] <- hpd01[2]
rateupperHPD[3] <- hpd02[2]
rateupperHPD[4] <- hpd03[2]
rateupperHPD[5] <- hpd04[2]
rateupperHPD[6] <- hpd05[2]
rateupperHPD[7] <- hpd10[2]
rateupperHPD[8] <- hpd11[2]
rateupperHPD[9] <- hpd12[2]
rateupperHPD[10] <- hpd13[2]
rateupperHPD[11] <- hpd14[2]
rateupperHPD[12] <- hpd15[2]
rateupperHPD[13] <- hpd20[2]
rateupperHPD[14] <- hpd21[2]
rateupperHPD[15] <- hpd22[2]
rateupperHPD[16] <- hpd23[2]
rateupperHPD[17] <- hpd24[2]
rateupperHPD[18] <- hpd25[2]
rateupperHPD[19] <- hpd30[2]
rateupperHPD[20] <- hpd31[2]
rateupperHPD[21] <- hpd32[2]
rateupperHPD[22] <- hpd33[2]
rateupperHPD[23] <- hpd34[2]
rateupperHPD[24] <- hpd35[2]
rateupperHPD[25] <- hpd40[2]
rateupperHPD[26] <- hpd41[2]
rateupperHPD[27] <- hpd42[2]
rateupperHPD[28] <- hpd43[2]
rateupperHPD[29] <- hpd44[2]
rateupperHPD[30] <- hpd45[2]
rateupperHPD[31] <- hpd50[2]
rateupperHPD[32] <- hpd51[2]
rateupperHPD[33] <- hpd52[2]
rateupperHPD[34] <- hpd53[2]
rateupperHPD[35] <- hpd54[2]
rateupperHPD[36] <- hpd55[2]
rateupperHPD[37] <- hpd60[2]
rateupperHPD[38] <- hpd61[2]
rateupperHPD[39] <- hpd62[2]
rateupperHPD[40] <- hpd63[2]
rateupperHPD[41] <- hpd64[2]
rateupperHPD[42] <- hpd65[2]
rateupperHPD[43] <- hpd70[2]
rateupperHPD[44] <- hpd71[2]
rateupperHPD[45] <- hpd72[2]
rateupperHPD[46] <- hpd73[2]
rateupperHPD[47] <- hpd74[2]
rateupperHPD[48] <- hpd75[2]
rateupperHPD[49] <- hpd80[2]
rateupperHPD[50] <- hpd81[2]
rateupperHPD[51] <- hpd82[2]
rateupperHPD[52] <- hpd83[2]
rateupperHPD[53] <- hpd84[2]
rateupperHPD[54] <- hpd85[2]


write(paste(i),file=paste("Hsap.meanRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Ptro.meanRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Pabe.meanRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Csab.meanRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Cjac.meanRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Mmur.meanRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Hsap.upperRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Ptro.upperRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Pabe.upperRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Csab.upperRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Cjac.upperRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Mmur.upperRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Hsap.lowerRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Ptro.lowerRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Pabe.lowerRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Csab.lowerRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Cjac.lowerRates.txt",sep=""),append=TRUE)
write(paste(i),file=paste("Mmur.lowerRates.txt",sep=""),append=TRUE)

for (k in 1:9)
{	
	maxy <- 0
	for (j in 1:6)
	{
		w <- ((k - 1)*6) + j
		if (rates[w] > maxy)
		{
			maxy <- rates[w]	
		}
		
		if (j == 1)
		{
			write(paste("\t",rates[w],sep=""),file=paste("Hsap.meanRates.txt",sep=""),append=TRUE)
			write(paste("\t",rateupperHPD[w],sep=""),file=paste("Hsap.upperRates.txt",sep=""),append=TRUE)
			write(paste("\t",ratelowerHPD[w],sep=""),file=paste("Hsap.lowerRates.txt",sep=""),append=TRUE)
		}
		if (j == 2)
		{
			write(paste("\t",rates[w],sep=""),file=paste("Ptro.meanRates.txt",sep=""),append=TRUE)
			write(paste("\t",rateupperHPD[w],sep=""),file=paste("Ptro.upperRates.txt",sep=""),append=TRUE)
			write(paste("\t",ratelowerHPD[w],sep=""),file=paste("Ptro.lowerRates.txt",sep=""),append=TRUE)
		}
		if (j == 3)
		{
			write(paste("\t",rates[w],sep=""),file=paste("Pabe.meanRates.txt",sep=""),append=TRUE)
			write(paste("\t",rateupperHPD[w],sep=""),file=paste("Pabe.upperRates.txt",sep=""),append=TRUE)
			write(paste("\t",ratelowerHPD[w],sep=""),file=paste("Pabe.lowerRates.txt",sep=""),append=TRUE)
		}
		if (j == 4)
		{
			write(paste("\t",rates[w],sep=""),file=paste("Csab.meanRates.txt",sep=""),append=TRUE)
			write(paste("\t",rateupperHPD[w],sep=""),file=paste("Csab.upperRates.txt",sep=""),append=TRUE)
			write(paste("\t",ratelowerHPD[w],sep=""),file=paste("Csab.lowerRates.txt",sep=""),append=TRUE)
		}
		if (j == 5)
		{
			write(paste("\t",rates[w],sep=""),file=paste("Cjac.meanRates.txt",sep=""),append=TRUE)
			write(paste("\t",rateupperHPD[w],sep=""),file=paste("Cjac.upperRates.txt",sep=""),append=TRUE)
			write(paste("\t",ratelowerHPD[w],sep=""),file=paste("Cjac.lowerRates.txt",sep=""),append=TRUE)
		}
		if (j == 6)
		{
			write(paste("\t",rates[w],sep=""),file=paste("Mmur.meanRates.txt",sep=""),append=TRUE)
			write(paste("\t",rateupperHPD[w],sep=""),file=paste("Mmur.upperRates.txt",sep=""),append=TRUE)
			write(paste("\t",ratelowerHPD[w],sep=""),file=paste("Mmur.lowerRates.txt",sep=""),append=TRUE)
		}
		
	}
	maxy <- maxy * 1.1
	
	if (k > 6)
	{
		par(mar=c(7,2,1,1))
	}
	
	if (maxy > 0 && maxy <= 0.0005)
	{
		plot(0,0,xlim=c(0.5,6.5),ylim=c(0,0.0005),col="white",pch=16,xlab="", ylab="", main="",bty='n',yaxt='n',xaxt='n')
		axis(2,at=c(0,0.0001,0.0002,0.0003,0.0004,0.0005),labels=c("0","0.1","0.2","0.3","0.4","0.5"))
		if (k <= 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
		}
		if (k > 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
			splabels=c(expression(paste(italic("Homo sapiens"))),expression(paste(italic("Pan troglodytes"))),expression(paste(italic("Pongo abelii"))),expression(paste(italic("Chlorocebus sabaeus"))),expression(paste(italic("Callithrix jacchus"))),expression(paste(italic("Microcebus murinus"))))
			text(x=c(1,2,3,4,5,6), y=par()$usr[3]-0.05*(par()$usr[4]-par()$usr[3]),labels=splabels, srt=45, adj=1, xpd=TRUE,cex=1.0)
		}
	}
	if (maxy > 0.0005 && maxy <= 0.001)
	{
		plot(0,0,xlim=c(0.5,6.5),ylim=c(0,0.001),col="white",pch=16,xlab="", ylab="", main="",bty='n',yaxt='n',xaxt='n')
		axis(2,at=c(0,0.0002,0.0004,0.0006,0.0008,0.001),labels=c("0","0.2","0.4","0.6","0.8","1.0"))
		if (k <= 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
		}
		if (k > 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
			splabels=c(expression(paste(italic("Homo sapiens"))),expression(paste(italic("Pan troglodytes"))),expression(paste(italic("Pongo abelii"))),expression(paste(italic("Chlorocebus sabaeus"))),expression(paste(italic("Callithrix jacchus"))),expression(paste(italic("Microcebus murinus"))))
			text(x=c(1,2,3,4,5,6), y=par()$usr[3]-0.05*(par()$usr[4]-par()$usr[3]),labels=splabels, srt=45, adj=1, xpd=TRUE,cex=1.0)
		}
	}
	if (maxy > 0.001 && maxy <= 0.0015)
	{
		plot(0,0,xlim=c(0.5,6.5),ylim=c(0,0.0015),col="white",pch=16,xlab="", ylab="", main="",bty='n',yaxt='n',xaxt='n')
		axis(2,at=c(0,0.0003,0.0006,0.0009,0.0012,0.0015),labels=c("0","0.3","0.6","0.9","1.2","1.5"))
		if (k <= 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
		}
		if (k > 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
			splabels=c(expression(paste(italic("Homo sapiens"))),expression(paste(italic("Pan troglodytes"))),expression(paste(italic("Pongo abelii"))),expression(paste(italic("Chlorocebus sabaeus"))),expression(paste(italic("Callithrix jacchus"))),expression(paste(italic("Microcebus murinus"))))
			text(x=c(1,2,3,4,5,6), y=par()$usr[3]-0.05*(par()$usr[4]-par()$usr[3]),labels=splabels, srt=45, adj=1, xpd=TRUE,cex=1.0)
		}
	}
	if (maxy > 0.0015 && maxy <= 0.002)
	{
		plot(0,0,xlim=c(0.5,6.5),ylim=c(0,0.002),col="white",pch=16,xlab="", ylab="", main="",bty='n',yaxt='n',xaxt='n')
		axis(2,at=c(0,0.0005,0.001,0.0015,0.002),labels=c("0","0.5","1.0","1.5","2.0"))
		if (k <= 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
		}
		if (k > 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
			splabels=c(expression(paste(italic("Homo sapiens"))),expression(paste(italic("Pan troglodytes"))),expression(paste(italic("Pongo abelii"))),expression(paste(italic("Chlorocebus sabaeus"))),expression(paste(italic("Callithrix jacchus"))),expression(paste(italic("Microcebus murinus"))))
			text(x=c(1,2,3,4,5,6), y=par()$usr[3]-0.05*(par()$usr[4]-par()$usr[3]),labels=splabels, srt=45, adj=1, xpd=TRUE,cex=1.0)
		}
	}
	if (maxy > 0.002 && maxy <= 0.003)
	{
		plot(0,0,xlim=c(0.5,6.5),ylim=c(0,0.003),col="white",pch=16,xlab="", ylab="", main="",bty='n',yaxt='n',xaxt='n')
		axis(2,at=c(0,0.0005,0.001,0.0015,0.002,0.0025,0.003),labels=c("0","0.5","1.0","1.5","2.0","2.5","3.0"))
		if (k <= 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
		}
		if (k > 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
			splabels=c(expression(paste(italic("Homo sapiens"))),expression(paste(italic("Pan troglodytes"))),expression(paste(italic("Pongo abelii"))),expression(paste(italic("Chlorocebus sabaeus"))),expression(paste(italic("Callithrix jacchus"))),expression(paste(italic("Microcebus murinus"))))
			text(x=c(1,2,3,4,5,6), y=par()$usr[3]-0.05*(par()$usr[4]-par()$usr[3]),labels=splabels, srt=45, adj=1, xpd=TRUE,cex=1.0)
		}
	}
	if (maxy > 0.003 && maxy <= 0.0035)
	{
		plot(0,0,xlim=c(0.5,6.5),ylim=c(0,0.0035),col="white",pch=16,xlab="", ylab="", main="",bty='n',yaxt='n',xaxt='n')
		axis(2,at=c(0,0.0005,0.001,0.0015,0.002,0.0025,0.003,0.0035),labels=c("0","0.5","1.0","1.5","2.0","2.5","3.0","3.5"))
		if (k <= 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
		}
		if (k > 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
			splabels=c(expression(paste(italic("Homo sapiens"))),expression(paste(italic("Pan troglodytes"))),expression(paste(italic("Pongo abelii"))),expression(paste(italic("Chlorocebus sabaeus"))),expression(paste(italic("Callithrix jacchus"))),expression(paste(italic("Microcebus murinus"))))
			text(x=c(1,2,3,4,5,6), y=par()$usr[3]-0.05*(par()$usr[4]-par()$usr[3]),labels=splabels, srt=45, adj=1, xpd=TRUE,cex=1.0)
		}
	}
	if (maxy > 0.0035 && maxy <= 0.004)
	{
		plot(0,0,xlim=c(0.5,6.5),ylim=c(0,0.004),col="white",pch=16,xlab="", ylab="", main="",bty='n',yaxt='n',xaxt='n')
		axis(2,at=c(0,0.001,0.002,0.003,0.004),labels=c("0","1.0","2.0","3.0","4.0"))
		if (k <= 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
		}
		if (k > 6)
		{
			axis(1,at=c(1,2,3,4,5,6),labels=FALSE)
			splabels=c(expression(paste(italic("Homo sapiens"))),expression(paste(italic("Pan troglodytes"))),expression(paste(italic("Pongo abelii"))),expression(paste(italic("Chlorocebus sabaeus"))),expression(paste(italic("Callithrix jacchus"))),expression(paste(italic("Microcebus murinus"))))
			text(x=c(1,2,3,4,5,6), y=par()$usr[3]-0.05*(par()$usr[4]-par()$usr[3]),labels=splabels, srt=45, adj=1, xpd=TRUE,cex=1.0)
		}
	}


	for (j in 1:6)
	{
		w <- ((k - 1)*6) + j		
		polygon(x=c((j-0.25),(j-0.25),(j+0.25),(j+0.25)),y=c(0,rates[w],rates[w],0),col="#d8b365")
		segments(j,ratelowerHPD[w],j,rateupperHPD[w],lwd=2)
	}
	if (k == 1)
	{
		mtext("Group 1",side=3,line=-1.0,cex=1.0)
	}
	if (k == 2)
	{
		mtext("Group 2",side=3,line=-1.0,cex=1.0)
	}
	if (k == 3)
	{
		mtext("Group 3",side=3,line=-1.0,cex=1.0)
	}
	if (k == 4)
	{
		mtext("Group 4",side=3,line=-1.0,cex=1.0)
	}
	if (k == 5)
	{
		mtext("Group 5",side=3,line=-1.0,cex=1.0)
	}
	if (k == 6)
	{
		mtext("Group 6",side=3,line=-1.0,cex=1.0)
	}
	if (k == 7)
	{
		mtext("Group 7",side=3,line=-1.0,cex=1.0)
	}
	if (k == 8)
	{
		mtext("Group 8",side=3,line=-1.0,cex=1.0)
	}
	if (k == 9)
	{
		mtext("Group 9",side=3,line=-1.0,cex=1.0)
	}
}
mtext("Branch",side=1,line=1.25,cex=1.2,outer=TRUE)
mtext(expression(paste("Absolute Rate of Evolution (x10"^-8,")")),side=2,line=1.0,cex=1.2,outer=TRUE)

dev.off()
write(paste("\n"),file=paste("Hsap.meanRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Ptro.meanRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Pabe.meanRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Csab.meanRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Cjac.meanRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Mmur.meanRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Hsap.lowerRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Ptro.lowerRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Pabe.lowerRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Csab.lowerRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Cjac.lowerRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Mmur.lowerRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Hsap.upperRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Ptro.upperRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Pabe.upperRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Csab.upperRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Cjac.upperRates.txt",sep=""),append=TRUE)
write(paste("\n"),file=paste("Mmur.upperRates.txt",sep=""),append=TRUE)
}
