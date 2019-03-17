myfunction <- function(RandomVariance=0, nbsim=1)
{
library(lme4)
sampsize <- 500
nbblocks <- 30
pvals <- vector(length = nbsim)
altpvals <- vector(length = nbsim)
for (i in 1:nbsim)
{
  x <- rnorm(sampsize,mean = 4, sd=0.25)
  block <- sample(x = 1:nbblocks, size = sampsize, replace = TRUE)
  blockvalues <- rnorm(n = nbblocks, mean = 0, sd = sqrt(RandomVariance))
  y <- 8 - x + blockvalues[block] + rnorm(sampsize,0,1)
  dat <- data.frame(response = y, predictor = x, block=block)
  lm0 <- lm(response ~ 1 + predictor, data=dat)
  lmm0 <- lmer(response ~ 1 + predictor + (1|block), data=dat )
  (LRT0 <- anova(lmm0, lm0)) #mixed model must come first!
  pvals[i] <- LRT0$`Pr(>Chisq)`[2] # the p-value
  altpvals[i] <- 1-pchisq(LRT0$Chisq[2],0.5) # a better p-value
}
output <- list(pvals=pvals, altpvals=altpvals)
return(output)
}

myfunction2 <- function()
{
  return(1+2)
}