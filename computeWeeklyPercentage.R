setwd('/Users/xinghai/Documents/Yahoo/NFL_collegeFootball/code/NFL_CollegeFootball')

spaceID = '95861059'
filePath = paste('../../', spaceID, 'New.csv', sep = "")
mydata = read.csv(filePath, header = F)

month = 12
yearrange = c(2010:2013)
averageAllMonth = yearrange
weeklyAverage = matrix(0, length(yearrange), 7)

for (year in yearrange) {
  monthlyData = mydata[which(mydata[,1] == year & mydata[,2] == month), c(4:5)]
  averageAllMonth[year - yearrange[1] + 1] = mean(monthlyData[,2])
  for (wday in 0:6) {
    weeklydata = monthlyData[which(monthlyData[,1] == wday), 2]
    weeklyAverage[year - yearrange[1] + 1, wday+1] = mean(weeklydata)
  }  
}

percentageWeeklyAverage = weeklyAverage
for (i in 1: nrow(percentageWeeklyAverage)) {
  percentageWeeklyAverage[i, ] = weeklyAverage[i, ] / sum(weeklyAverage[i, ])
}

gainWeeklyAverage = weeklyAverage
for (i in 1: nrow(gainWeeklyAverage)) {
  gainWeeklyAverage[i, ] = weeklyAverage[i, ] / averageAllMonth[i] - 1
}
write.csv(gainWeeklyAverage, "Dec.csv")
print(gainWeeklyAverage)