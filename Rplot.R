library(R.matlab)
library(rgl)
library(ggplot2)
setwd("/Users/gaozhe/Desktop/三院项目")
data <- readMat("/Users/gaozhe/Desktop/三院项目/data.mat")

a = 10
b = 5
c = 5
r = 3.5

th = seq(0, 2*pi, 2*pi/99)
phi = seq(0, pi, 2*pi/99)
x = a * cos(th) %*% t(sin(phi))
y = b * sin(th) %*% t(sin(phi))
z = c * rep(1, length(th)) %*% t(cos(phi))


y0 = matrix(rep(seq(-20, 20, 0.1), length(seq(-20, 20, 0.1))), nrow = length(seq(-20, 20, 0.1)))
z0 = t(matrix(rep(seq(-20, 20, 0.1), length(seq(-20, 20, 0.1))), nrow = length(seq(-20, 20, 0.1))))

open3d()
surface3d(x, y, z, color = 'red',  back = "lines")

for(i in 1 : length(data$cut.point)){
  x0 = matrix(data$cut.point[i], nrow = length(seq(-20, 20, 0.1)), ncol = length(seq(-20, 20, 0.1)))
  surface3d(x0, y0, z0, color = 'blue',  back = "points", alpha = 0.1)
}

for (i in 2 : (length(data$cut.point) - 2)) {
  filename <- paste0("data", i, ".mat")
  data.temp <- readMat(filename)
  xloc <- (data$cut.point[i] + data$cut.point[i+1])/2
  for (j in 1 : length(data.temp$KK)) {
    theta <- atan(data.temp$KK[j])
    rot.matx <- matrix(c(1, 0, 0, 0, cos(theta), sin(theta), 0, -sin(theta),  cos(theta)), nrow = 3)
    x1 = r * cos(th) %*% t(rep(1, length(seq(-15, 15, 0.1))))
    y1 = r * sin(th) %*% t(rep(1, length(seq(-15, 15, 0.1))))
    z1 = rep(1, length(th)) %*% t(seq(-15, 15, 0.1))
    
    da <- rot.matx %*% rbind(as.vector(x1), as.vector(y1), as.vector(z1))
    x1n <- matrix(da[1,], nrow = 100)
    y1n <- matrix(da[2,], nrow = 100)
    z1n <- matrix(da[3,], nrow = 100)
    x1n <- x1n + xloc
    z1n <- z1n + (data.temp$LL[j] + data.temp$LL1[j])/2
    surface3d(x1n, y1n, z1n, color = 'green',  back = "lines")
  }
}


