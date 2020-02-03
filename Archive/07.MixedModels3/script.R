hares <- read.csv("hares.csv")
summary(hares)

lm0 <- lm(detectability ~ 1 + darkness, data = hares)
summary(lm0)

library(lme4)
lmm0 <- lmer(detectability ~ 1 + darkness + (1|location), data = hares)
summary(lmm0)
hist(as.numeric(ranef(lmm0)$location[,1]))

lmm1 <- lmer(detectability ~ 1 + darkness + (1+ darkness|location), data = hares)
summary(lmm1)

mhar <- lmer(detectability ~ 1 + darkness + (1+darkness|location),
             data = hares)

rhar <- ranef(mhar)$location
fhar <- fixef(mhar)
dark<-0:6
plot(x=dark, y=fhar[1]+dark*fhar[2], ylim=c(0,4), type="l", 
     lwd=5, lty=2, main="Mean effect (dotted),
     Median effect (dashed) and location slopes")
cls <- rainbow(n = nrow(rhar))
for(i in 1:50)
{
  y <- (fhar[1] + rhar[i,1]) +
    dark*(fhar[2]+ rhar[i,2])
  
  lines(x = dark, y=y, col=cls[i])
}
abline(lm(detectability ~ 1 + darkness, data=hares), lwd=5)
##### VOLES ####
voles <- read.table("AllM.txt", header = TRUE)
summary(voles)

summary(lm(fitnessR ~ 1 + Age + Weight, data=voles))

summary(volm<- lmer(fitnessR ~ 1 + Age + Weight + (1 + Weight|Year), data=voles))
ranef(volm)
fixef(volm)


rhar <- ranef(volm)$Year
fhar <- fixef(volm)
weight <- 10:50
plot(x=weight, y=fhar[1]+weight*fhar[3], ylim=c(0,4), type="l", 
     lwd=5, lty=2, main="")
cls <- rainbow(n = nrow(rhar))
for(i in 1:nrow(rhar))
{
  y <- (fhar[1] + rhar[i,1]) +
    weight*(fhar[3]+ rhar[i,2])
  
  lines(x = weight, y=y, col=cls[i])
}
abline(lm(fitnessR ~ 1 + Weight, data=voles), lwd=5)


x<- rnorm(100)
y <- 2+x + rnorm(100)
plot(x,y)
abline(lm(y ~ x), col="red", lwd=3)
abline(lm(y ~ 0 + x), col="blue", lwd=3)
abline(h=0)
abline(v=0)
model.matrix(lm(y ~ x))
