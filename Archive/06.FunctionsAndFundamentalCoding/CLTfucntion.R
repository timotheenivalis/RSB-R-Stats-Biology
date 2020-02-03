cltfunction <- function(n=1000, nbdistri=100)
{
  output <- vector(length = n)
rddistri <- list(rnorm, runif, rpois)

for (i in 1:nbdistri)
{
  choosedistri <- sample(1:length(rddistri), size = 1)
  if(choosedistri %in% 1)
  {
    output <- output + rddistri[[choosedistri]](n, rnorm(1), runif(1,0,1))
  }
  if(choosedistri %in% 2)
  {
    output <- output + rddistri[[choosedistri]](n, 0, runif(1,0.1,3))
  }
  if(choosedistri %in% 3)
  {
    output <- output + rddistri[[choosedistri]](n, exp(runif(1)))
  }
}
plot(density(output))
lines(x=seq(min(output),max(output),by = 1), y=dnorm(seq(min(output),max(output),by = 1), mean = mean(output), sd=sd(output)), col="red")
legend(x="topright", legend = c("simulation", "Normal distribution"), col=c("black", "red"), lwd=1)
return(shapiro.test(output))
}


cltfunction()

halfmean1 <- function(x)
{
  mean(x)/2
}
halfmean2 <- function(x,...)
{
  mean(x,...)/2
}
halfmean3 <- function(x,na.rm)
{
  mean(x,na.rm=na.rm)/2
}

somedata <- c(10, 25, NA)
halfmean1(somedata)
halfmean2(somedata)

halfmean1(somedata, na.rm=TRUE)
halfmean2(somedata, na.rm=TRUE)
halfmean3(somedata, na.rm=TRUE)

halfmean2(somedata, guhu=TRUE)




f0 <- function(x=2){
  x <- x
  y <- x+2
  return(y)
}

f1 <- function(x=2){
  x <<- x
  y <- x+2
  return(y)
}

x <- rnorm(1000)
f0()+x

x <- rnorm(1000)
f1()+x
x+f1()
x

tree<-function(x,y,l,dir,n,nmax){
  if(n==0){
    return()
  }
  pos<-round(runif(1,1,199))
  colour=rainbow(200,start=0.2,end=0.6,v=0.6)[pos]
  lines(c(x,x+l*sin(dir)),c(y,y+l*cos(dir)),
        lwd=20*(n/nmax),col=colour)
  branches<-round(runif(1,2,4))
  for(i in 1:branches){
    angle<-dir+(-pi/6)+(pi/3)*(i-1)/(branches-1)
    l2<-runif(1,0.7,0.85)*l
    tree(x+l*sin(dir),y+l*cos(dir),l2,angle,n-1,nmax)
  }
}

plot(0,0,type="n",xlim=c(-10,10),ylim=c(0,10),
     xaxt="n",yaxt="n",ylab="",xlab="")
tree(0,0,2,0,8,4)


ped <- read.csv("SlideExercisesAndData/wrongpedigree.csv")
head(ped)


