setwd('/Users/xinghai/Documents/Yahoo/NFL_collegeFootball/code/NFL_CollegeFootball')

spaceID = '95861059'
filePath = paste('../../', spaceID, 'New.csv', sep = "")
mydata = read.csv(filePath)