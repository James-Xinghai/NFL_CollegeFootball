setwd('/Users/xinghai/Documents/Yahoo/NFL_collegeFootball/code/NFL_CollegeFootball')

spaceID = '95861059'
filePath = paste('../../', spaceID, 'Segs.csv', sep = "")
mydata = read.csv(filePath, header = F)

datamat = as.matrix(mydata)
s <- svd(datamat)
mainPrincipal <- (s$u)[,1]
