jump <- read.csv("jumpingdistance.csv")
str(jump)
summary(jump)
plot(jump)
plot(jump$mass, jump$jump, ylim=c(0,8), xlim=c(0,80))
abline(lm(jump ~ mass, data = jump), col="red")
summary(lm(jump ~ mass, data = jump))
summary(lm(jump ~ height, data = jump))
summary(lm(jump ~ mass + height, data = jump))
plot(lm(jump ~ mass + height, data = jump))


babies <- read.csv("babies.csv")
str(babies)
summary(lm(babies_born ~ 1 + number_of_storks, data=babies))
summary(lm(babies_born ~ 1 + mean_temperature, data=babies))

summary(lm(babies_born ~ 1 + number_of_storks + year, data=babies))
summary(lm(babies_born ~ 1 + mean_temperature + year, data=babies))
summary(lm(babies_born ~ 1 +  number_of_storks + mean_temperature + year, data=babies))
summary(lm(babies_born ~ 1 +  year, data=babies))



x <- rnorm(1000)
z <- x + rnorm(1000)
y <- x +z+ rnorm(1000)
summary(lm(y ~ x + z))
summary(aov(y ~ x + z))


birds <- read.csv("loyn.csv")
plot(birds)

summary(lm(ABUND ~ 1 + log(AREA) + ALT + as.factor(GRAZE)+ DIST + YR.ISOL, data = birds))
summary(lm(ABUND ~ 1 + log(AREA) * ALT + as.factor(GRAZE), data = birds))

summary(lm(ABUND ~ 1 + YR.ISOL, data = birds))
summary(lm(ABUND ~ 1 + ALT, data = birds))


x<- rnorm(1000)
y <- x + rnorm(1000)

obs <- sapply(y, function(y){rbinom(n = 1, 1, prob = 1/(1+exp(-y)))})
m0 <- glm(obs ~ x, family = "binomial")
summary(m0)


car::Anova(m0)
