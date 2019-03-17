source("function3.R")

mean
apply
?apply

myfunction <- function(x, y, z){
  multiplyvalue <- x*y*z
  sumvalue <- x + y +z
  myoutput <- c(multiplyvalue, sumvalue)
  return(myoutput)
}
myfunction(x = 3,y = 5, z=2)




myfunction(RandomVariance = 10, nbsim = 20)


x <- rnorm(2000, mean = 0, sd = 1)
mean(x)
sd(x)
