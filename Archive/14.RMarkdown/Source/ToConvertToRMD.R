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

library(ggplot2)
g <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width))
g <- g + geom_point(aes(shape = factor(iris$Species), colour = factor(iris$Species)))
g <- g + ggtitle (" SepalLength Vs SepalWidth wrt Species" )
g <- g + stat_smooth(method= lm)
g



#can we easily cluster species with the original measurements?
kcluster <- kmeans(x=iris[,c(1:4)], centers = 3)
table(iris$Species, kcluster$cluster)

# What about our ratio?
kclusterRatio <- kmeans(x=iris[,6], centers = 3)
table(iris$Species, kclusterRatio$cluster)

#maybe measurements are redundant?
cmat <- cor(iris[,-5])

#smart people have looked at this data more. Maybe use things from http://rstudio-pubs-static.s3.amazonaws.com/450733_9a472ce9632f4ffbb2d6175aaaee5be6.html
#or https://rpubs.com/Tanmay007/Iris_regression