tab <- read.csv(input_files[[1]])
print(summary(tab))

ta <- with(tab, data.frame(
	idnum=OrgDefinedId
	, paperVersion=Version_MT2
))

# rdsave(ta)
