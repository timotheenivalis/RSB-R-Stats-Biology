data("iris")

library(ggplot2)

ggplot(iris,  aes(x=Species, y=Sepal.Length))+geom_boxplot()+geom_point()

nrow(iris[iris$Species %in% c("setosa", "versicolor"),])




nbsim <- 1000
pdistri_large <- vector(length = nbsim)
pdistri_small <- vector(length = nbsim)
for (i in 1:nbsim)
{
  #small sample size
  x1 <- rnorm(n = 10, mean = 2, sd = 1)
  x2 <- rnorm(n = 10, mean = 2.1, sd = 1)
  #large sample size
  x3 <- rnorm(n = 1000000, mean = 2, sd = 1) 
  x4 <- rnorm(n = 1000000, mean = 2.1, sd = 1) 
  out_large <- t.test(x3, x4)
  out_small <- t.test(x1, x2)
  pdistri_large[i]<-out_large$p.value
  pdistri_small[i]<-out_small$p.value
}

par(mfrow=c(1,2), cex=2)
hist(pdistri_large, xlim=c(0,1),
     main=paste("Prop signif=",mean(pdistri_large<0.05)))
hist(pdistri_small, xlim=c(0,1),
     main=paste("Prop signif=",mean(pdistri_small<0.05)))
plot(y=c(x3,x4), x=rep(c(1,2), each=10^6))
mean(x3)
mean(x4)
sd(x3)/sqrt(length(x3))



pvs <- FALSE
count<- 0
while(!pvs)
{
  count <- count + 1
  x <- rnorm(10)
  y <- rnorm(10)
  lmexample <- lm(y~x)
  pval <- coefficients(summary(lmexample))[2, 4]
  pvs <- pval<0.001
}
count
pval

plot(x,y)

pvalvec <- vector(length = 1000)
for(i in 1:1000)
{
x <- rnorm(10000)
y <- rnorm(10000)
lmexample <- lm(y~x)
pvalvec[i] <- coefficients(summary(lmexample))[2, 4]
}
hist(pvalvec)
min(pvalvec)
plot(density(pvalvec, from = 0, to=1))
