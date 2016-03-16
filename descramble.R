
orderedAnswers <- as.data.frame(t(sapply(rownames(scoreVersion), function(rn){
	version <- scoreVersion[[rn, "bestVer"]]
	test <- answers[rn, ]
	return(test[order(versionOrder[[version]])])
})))

names(orderedAnswers) <- paste("Q", 1:length(orderedAnswers), sep="")

correct <- sapply(1:length(key), function(q){
	return(mean(
		orderedAnswers[[q]]==key[[q]]
	))
})

qframe <- data.frame(
	q = 1:length(key), 
	correct
)

print(qframe[order(correct), ])
print(summary(orderedAnswers))

# rdsave(orderedAnswers, key)

