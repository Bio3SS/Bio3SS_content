
par(cex=1.5)

nq <- 1000
gen <- c(10, 15)
shape <- c(3)
top <- 0.08
maxTime <- 50

q <- (2*(1:nq)-1)/(2*nq)

for(g in gen){
	dist <- qgamma(q, scale=g/shape, shape=shape)

	dname <- "Approximate generation intervals"

	print(hist(dist
		, 	probability=TRUE
		, main=dname
		, xlab="Generation interval (days)"
		, xlim=c(0, maxTime)
		, ylim=c(0, top)
		, breaks=seq(0, 150, by=5)
	))
}

