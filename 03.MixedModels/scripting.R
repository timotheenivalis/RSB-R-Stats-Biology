mice <- read.csv("Data/challenge2.csv")
head(mice)
summary(mice)

lm0 <- lm(Percent.loss ~ 1 + Group , data = mice)
summary(lm0)
anova(lm0)

library(lme4)
lmRE <- lmer(Percent.loss ~ 1 + Group + (1|Cage), data = mice)
summary(lmRE)

lmplus <- lm(Percent.loss ~ 1 + Group + Cage, data = mice)
summary(lmplus)
lm0 <- lm(Percent.loss ~ 1 + Group , data = mice)




smm <- read.csv("Data/smm.csv")
head(smm)
summary(lmm0 <- lmer(y ~ 1+x + (1+x|year)+ (1|location), data=smm))
plot(lmm0)
residuals(lmm0)
vc0 <-VarCorr(lmm0)
as.numeric(vc0$year)
fixef(lmm0)
ranef(lmm0)
sigma(lmm0)

plot(x=smm$x, y=predict(lmm0))
plot(x=smm$x, y=smm$y)
points(x=smm$x, y=predict(lmm0), col="red")

plot(x=smm$x, y=predict(lmm0, re.form=~(1|location)))
plot(x=smm$x, y=predict(lmm0, re.form=~(1|year)))
plot(x=smm$x, y=predict(lmm0))
