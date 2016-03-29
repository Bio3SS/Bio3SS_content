set.seed(628)

par(cex=1.5)

nq <- 1000
time <- 15
shapes <- c(1, 5, 10, 20)

q <- (2*(1:nq)-1)/(2*nq)

for(s in 1:length(shapes)){
	shape <- shapes[[s]]
	gen <- qgamma(q, scale=time/shape, shape=shape)

	dname <- "Approximate generation intervals"

	print(hist(gen
		, 	probability=TRUE
		, main=dname
		, xlab="Generation interval"
		, xlim=c(0, 50)
		, breaks=seq(0, 150, by=5)
	))

	print(shape)

	curve((1+x)
		, xlim=c(0.1, 2)
		, ylim=c(1, 5)
		, xlab = "Exponential growth rate (per month)"
		, ylab = "Effective reproductive number R"
	)

	for (ss in 1:s){
		curve(((1+x/shapes[ss])^shapes[ss])
			, add=TRUE
		)
	}

	curve(((1+x/shape)^shape)
		, add=TRUE
		, col="blue"
	)
}

