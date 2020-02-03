voles <- read.csv("VoleWeight.csv")

m0 <- lm(Weight ~ Body_Length, data = voles)
AIC(m0)

m1 <- lm(Weight ~ Sex+Body_Length, data = voles)
AIC(m1)

anova(m1,m0)

m2 <- lm(Weight ~ Age*Sex +temperature*humidity + as.factor(Year), data = voles)
options(na.action="na.fail")
library(MuMIn)
drm2 <- dredge(m2, fixed = ~Age*Sex)
drm2

drm2bic <- dredge(m2, fixed = ~Age*Sex, rank = BIC)
drm2bic


respiro <- read.csv("metabo.csv")
m0 <- lm(respiration ~ I(mass^(2/3)), data=respiro)
m1 <- lm(respiration ~ I(mass^(3/4)), data=respiro)
m2 <- lm(respiration ~ I(log(mass)), data=respiro)
AIC(m0,m1,m2)
