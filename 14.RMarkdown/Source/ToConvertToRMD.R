# Let's analyse the iris data set
# Load the data
data("iris")
#Look at it
str(iris)
summary(iris)
head(iris)#would be nice to see that as a clean table
plot(iris)
#sample size /species
table(iris$Species)

#Can we distinguish species based on flower morphology?
#try a linear model like sepal.length = species + noise
summary(m0 <- lm(Sepal.Length ~ 1 + Species, data = iris))
anova(m0)#that looks convincing

#But are proportions also different?
iris$Sepal.Shape <- iris$Sepal.Length/iris$Sepal.Width
summary(mshape0 <- lm(Sepal.Shape ~ 1 + Species, data = iris))
boxplot(Sepal.Shape ~ 1 + Species, data = iris)
#so 1 species different from the two others (which are pretty similar in shape, but not size!)
