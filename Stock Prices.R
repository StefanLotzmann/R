runs <- 100000
#simulates future movements and returns the closing price on day 200
generate.path <- function(){
  days <- 200
  changes <- rnorm(200,mean=1.001,sd=0.005)
  sample.path <- cumprod(c(20,changes))
  closing.price <- sample.path[days+1] #+1 because we add the opening price
  return(closing.price)
}

mc.closing <- replicate(runs,generate.path())
mc.closing
