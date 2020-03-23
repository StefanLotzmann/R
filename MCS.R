runs <- 100000
sims <- rnorm(runs,mean=1,sd=10)
mc.integral <- sum(sims >= 3 & sims <= 6)/runs
mc.integral 
