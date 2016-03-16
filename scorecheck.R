media <- read.csv(input_files[[1]], header=FALSE)
names(media) <- c("email", "idnum", "mscore")

# Students missing from media report (should be none)
noMedia <- setdiff(sort(bubbleScores$idnum), sort(media$idnum))
if(length(noMedia)>0){print(noMedia)}

# Students missing from Bubble report (may be somehow recorded as zeroes)
noBubble <- setdiff(sort(media$idnum), sort(bubbleScores$idnum))
if(length(noBubble)>0){print(subset(media, idnum %in% noBubble))}

comp <- merge(media, bubbleScores)
if (identical(comp$score, comp$mscore)){
	print("Everything matches.")
} else {
	print("Mismatched scores")
	print(subset(comp, mscore != score))
}

# rdnosave

