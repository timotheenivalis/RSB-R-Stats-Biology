thorns <- read.table("thorndata.txt", header = TRUE)
head(thorns)

summary(lm0 <- lm(herbivory ~ 1 + thorndensity, data=thorns))

library(lme4)
summary(lmm0 <- lmer(herbivory ~ 1 + thorndensity + (1|site), data=thorns))

lmm0@devcomp
confint(lmm0)

anova( lmm0, lm0)




RandomVariance <- 0
sampsize <- 500
nbblocks <- 30
pvals <- vector(length = 1000)
altpvals <- vector(length = 1000)
for (i in 1:1000)
{
  x <- rnorm(sampsize,mean = 4, sd=0.25)
  block <- sample(x = 1:nbblocks, size = sampsize, replace = TRUE)
  blockvalues <- rnorm(n = nbblocks, mean = 0, sd = sqrt(RandomVariance))
  y <- 8 - x + blockvalues[block] + rnorm(sampsize,0,1)
  dat <- data.frame(response = y, predictor = x, block=block)
  lm0 <- lm(y ~ x)
  lmm0 <- lmer(y ~ x + (1|block))
  ao0 <- anova(lmm0, lm0)
  pvals[i] <- ao0$`Pr(>Chisq)`[2]
  altpvals[i] <- 1-pchisq(ao0$Chisq[2], df = 0.5)
}

hist(pvals)
hist(altpvals)
mean(altpvals <= 0.05)
mean(pvals/2 <= 0.05)











roo <-read.csv("ExercisesSlidesAndData/roo.csv")

head(roo)

roolmm <- lmer(EscapeDistance ~ 1 + Age3+ (1|id) + (1|Year), data=roo)
summary(roolmm)

59.94 / (59.94+38.27)
17.39 / (17.39 + 19.05)
confint(roolmm)

roonull <- lm(EscapeDistance ~ 1 , data=roo)
anova(roolmm, roonull)
