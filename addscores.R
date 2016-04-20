tot <- NULL
for (l in input_files){
	df <- read.csv(l)[-1]
	if (is.null(tot)) tot <- df
	else{
		if (!identical (tot$idnum, df$idnum)) stop;
		tot$score = tot$score+df$score
	}
}

print(mean(tot$score))
write.csv(tot, csvname)
