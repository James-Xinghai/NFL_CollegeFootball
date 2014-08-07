setwd('/Users/xinghai/Documents/Yahoo/NFL_collegeFootball/code/NFL_CollegeFootball')

spaceID = '95861059'
filePath = paste('../../', spaceID, 'New.csv', sep = "")
mydata = read.csv(filePath, header = F)

yearlist  <- mydata[seq(from = 4, to = nrow(mydata), by = 7),1]
monthlist <- mydata[seq(from = 4, to = nrow(mydata), by = 7),2]
daylist   <- mydata[seq(from = 4, to = nrow(mydata), by = 7),3]

numOfDays <- nrow(mydata)
numOfWeeks <- (numOfDays - 3)/7

datamat <- matrix(mydata[4:nrow(mydata), 5], nrow = 7)
weeksum <- colSums(datamat)
percentagemat <- datamat %*% diag(1/weeksum) 

s <- svd(percentagemat)

pattern1 <- abs((s$u)[,1])
pattern2 <- abs((s$u)[,2])

# solve a sparse coding problem: \sum{||x_i-D\alpha_i||^2/2+\lambda||\alpha_i||_1}
# initialize the dictionary with what PCA learns
D = s$u
lambda = 0.05

# iterate to optimize D and \alphai
round = 10
innerround = 10
t = 0.01 # learning rate
thres = t * lambda

# normalize the column of percentagemat, 


alpha = matrix(0, 7, numOfWeeks)
for (it in 1: round) {
  # fix D to optimize \alpha_i
  for ( j in 1:numOfWeeks ) {
    for (k in 1:innerround) {
      alpha[,j] = alpha[,j] + t * t(D) %*% (percentagemat[,j] - D %*% alpha[, j])
      greatindex = which(alpha[,j] > thres)
      smallindex = which(alpha[,j] < -thres)
      betweenindex = which(alpha[,j] <= thres & alpha[,j] >= -thres)
      alpha[betweenindex, j] = 0
      alpha[greatindex, j]   = alpha[greatindex, j] - thres * rep(1, length(greatindex))
      alpha[smallindex, j]   = alpha[smallindex, j] + thres * rep(1, length(smallindex))
    }
  }
  # fix \alpha to optimize D
  for (k in 1:innerround) {
    A <- percentagemat %*% t(alpha)
    B <- alpha %*% t(alpha)
    gradD <- D * B - A
    D <- D - gradD * t
  }
}

