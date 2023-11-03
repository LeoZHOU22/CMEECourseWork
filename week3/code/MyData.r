Mydata <- read.csv("../data/trees.csv")
ls(pattern = "My")
class(Mydata)
head(Mydata)
str(Mydata)
Mydata <- read.csv("../data/trees.csv", header = F)
head (Mydata)

write.csv(Mydata, "../results/Mydata.csv")
write.csv(Mydata, "../results/Mydata.csv", row.names=TRUE) # write row names
write.table(Mydata, "../results/Mydata.csv", col.names=FALSE) # ignore col names
