coords <- function(r, v=4, xc=0, yc=0, offset=0){
	angle <- 2*pi/v
	points <- (0:v) + offset - 1/2
	return(data.frame(
		x=r*cos(angle*points)
		, y=r*sin(angle*points)
	))
}

cpoly <- function(r, v=4, xc=0, yc=0, offset=0, color="white"){
	with(coords(r, v, xc, yc, offset), {
		polygon(col=color, x=x , y=y)
	})
}

for(rot in 1:10){
	plot(NULL, NULL 
		, xlab=""
		, ylab=""
		, axes=FALSE
		, xlim = c(-1, 1)
		, ylim = c(-1, 1)
	)

	for(i in 1:16){
		rc <- sqrt(2)^(1-i)
		cpoly(r=sqrt(2)*rc, offset=(i-1)%%rot/rot, col="blue")
		cpoly(r=rc, v=100)
	}
}
