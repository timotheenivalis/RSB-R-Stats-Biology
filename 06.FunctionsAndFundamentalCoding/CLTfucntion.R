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