library(dplyr)

maxScore <- 15

tot <- read.csv(input_files[[1]])

summary(tot)

tot <- (tot 
	%>% mutate(p=score/maxScore)
	%>% mutate(p = ((43*p+27)*sqrt(2025*p^2-3510*p+1681)-135*p^2+2222*p-1107) /(70*sqrt(2025*p^2-3510*p+1681)+1350*p-370))
	%>% mutate(score=p*maxScore)
	%>% select(idnum, score)
)

print(mean(tot$score))

write.csv(format(tot, digits=2), csvname)

