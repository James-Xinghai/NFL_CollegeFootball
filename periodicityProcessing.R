setwd('/Users/xinghai/Documents/Yahoo/NFL_collegeFootball/code/NFL_CollegeFootball')

spaceID = '95861059'
filePath = paste('../../', spaceID, 'New.csv', sep = "")
mydata = read.csv(filePath)

monthlist <- rep(12, 0)
weeklist  <- rep(7, 0)
weeklistInRegularSeason <- rep(7, 0)

for (i in 1:12) {
  monthlist[i] <- mean(mydata[which(mydata[, 2] == i) ,5])
}

for (i in 0:6) {
  weeklist[i+1] <- mean(mydata[which(mydata[, 4] == i) ,5])
}

for (i in 0:6) {
  weeklistInRegularSeason[i+1] <- mean(mydata[which((mydata[,2] <=2 | mydata[,2] >= 9) & mydata[,4] == i), 5])
}



