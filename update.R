f1 <- read.csv(input_files[[1]])
f2 <- read.csv(input_files[[2]])
f <- merge(f1, f2, by="idnum")
print(f)

n <- with(f, data.frame(
	idnum=idnum
	, score = pmax(score.x, score.y)
))

write.csv(n, csvname)
