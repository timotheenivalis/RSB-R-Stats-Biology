survdat <- read.csv(file = "survivalsize.csv")
summary(survdat)
plot(survdat)
plot(x = survdat$size, y = survdat$survival)
summary(survglm <- glm(survival ~ 1 + size, data = survdat, family = "binomial"))
plot(survglm)
plogis(-13.4781)

x<- rnorm(1000)
y <- x +rnorm(1000)
plot(lm(y ~ x))


plot(x=survdat$size,
     y=predict(survglm, type="response"))

newdat <- data.frame(size=seq(from=3, to=8, length.out = 100))

plot(x=newdat$size,
     y=predict(survglm,newdata = newdat, type="response"), type = "l")

newdat <- cbind(newdat, predict(survglm,newdata = newdat,
                                type="response", se.fit = TRUE))
lines(x=newdat$size, y = newdat$fit+2*newdat$se.fit, lty=2)
lines(x=newdat$size, y = newdat$fit-2*newdat$se.fit, lty=2)

mean(predict(survglm, type="response"))
mean(survdat$survival)

mean(plogis(-13.4781 + 2.8078*survdat$size))
mean(1/(1+exp(-(-13.4781 + 2.8078*survdat$size))))
exp(2.8078)

p5 <- 1/(1+exp(-(-13.4781 + 2.8078*5)))
p6 <- 1/(1+exp(-(-13.4781 + 2.8078*6)))
(p6/(1-p6))/(p5/(1-p5))
