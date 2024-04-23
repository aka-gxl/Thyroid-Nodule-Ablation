elli_line <- function(x0, y0, theta, a, b, h, r){
  x.sel <- vector()
  y.sel <- vector()
  if(h %% 2 == 0){
    v = 0
  }else{
    v = 1
  }
  
  m <- ceiling(2 * b/sqrt(3))
  for (i in 1 : m) {
    res_xy <- elli_search(x0, y0, h, v, theta, r)
    if(res_xy[[2]][1,1]^2/a^2 + res_xy[[2]][2,1]^2/b^2 <= 1 | res_xy[[2]][1,2]^2/a^2 + res_xy[[2]][2,2]^2/b^2 <= 1){
      x.sel <- c(x.sel, res_xy[[1]][1])
      y.sel <- c(y.sel, res_xy[[1]][2])
    }
    v = v + 1 
  }
  
  for (j in 1 : m) {
    v = -j
    res_xy <- elli_search(x0, y0, h, v, theta, r)
    if(res_xy[[2]][1,1]^2/a^2 + res_xy[[2]][2,1]^2/b^2 <= 1 | res_xy[[2]][1,2]^2/a^2 + res_xy[[2]][2,2]^2/b^2 <= 1){
      x.sel <- c(x.sel, res_xy[[1]][1])
      y.sel <- c(y.sel, res_xy[[1]][2])
    }
  }
  
  list(x.sel, y.sel)
}

elli_pla <- function(x0, y0, theta, a, b, r){
  # 
  x.sel <- vector()
  y.sel <- vector()
  x.sel[1] <- x0
  y.sel[1] <- y0
  h = 0
  v = 1
  flag = 0
  while(flag == 0){
    res_xy <- elli_search(x0, y0, h, v, theta, r)
    if(res_xy[[2]][1,1]^2/a^2 + res_xy[[2]][2,1]^2/b^2 <= 1 | res_xy[[2]][1,2]^2/a^2 + res_xy[[2]][2,2]^2/b^2 <= 1){
      x.sel <- c(x.sel, res_xy[[1]][1])
      y.sel <- c(y.sel, res_xy[[1]][2])
      v = v + 1
    }else{
      flag = 1
    }
  }
  
  flag = 0
  v = -1
  while(flag == 0){
    res_xy <- elli_search(x0, y0, h, v, theta, r)
    if(res_xy[[2]][1,1]^2/a^2 + res_xy[[2]][2,1]^2/b^2 <= 1 | res_xy[[2]][1,2]^2/a^2 + res_xy[[2]][2,2]^2/b^2 <= 1){
      x.sel <- c(x.sel, res_xy[[1]][1])
      y.sel <- c(y.sel, res_xy[[1]][2])
      v = v - 1
    }else{
      flag = 1
    }
  }

  h = 1
  res_xy[[1]] = 1
  while (length(res_xy[[1]]) > 0) {
    res_xy <- elli_line(x0, y0, theta, a, b, h, r)
    x.sel <- c(x.sel, res_xy[[1]])
    y.sel <- c(y.sel, res_xy[[2]])
    h = h + 1
  }

  h = -1
  res_xy[[1]] = 1
  while (length(res_xy[[1]]) > 0) {
    res_xy <- elli_line(x0, y0, theta, a, b, h, r)
    x.sel <- c(x.sel, res_xy[[1]])
    y.sel <- c(y.sel, res_xy[[2]])
    h = h - 1
  }

  list(x.sel, y.sel)
}

elli_search <- function(x0, y0, numh, numv, theta, r){
  # 
  # 
  x <- vector()
  y <- vector()
  if(numh == 0){
    x[1] <- 0.5 * r
    y[1] <- sign(numv) * r * (sqrt(3)  * abs(numv) - sqrt(3)/2)
    x[2] <- - 0.5 * r
    y[2] <- sign(numv) * r * (sqrt(3) * abs(numv) - sqrt(3)/2)
    
    res <- matrix(c(cos(theta), sin(theta), -sin(theta), cos(theta)), nrow = 2) %*% rbind(x, y) + matrix(c(x0, y0, x0, y0), nrow = 2)
    res.ori <- matrix(c(cos(theta), sin(theta), -sin(theta), cos(theta)), nrow = 2) %*% c(0, numv * r * sqrt(3)) + c(x0, y0)
    return(list(res.ori, res))
  }
  
  
  
  if(numh %% 2 == 0 & numh != 0){
    m = abs(numh)/2
    x[1] <- sign(numh) * r * (3 * m - 0.5) 
    y[1] <- sign(numv) * r * (sqrt(3) * abs(numv) - sqrt(3)/2)
    x[2] <- sign(numh) * r * (3 * m - 1)
    y[2] <- sign(numv) * r * sqrt(3) * abs(numv)
  }
  
  if(numh %% 2 == 1){
    m = (abs(numh) - 1)/2
    x[1] <- sign(numh) * r * (3 * m + 1.5 - 0.5)
    y[1] <- sign(numv) * r * (sqrt(3) * abs(numv) - sqrt(3))
    x[2] <- sign(numh) * r * (3 * m + 1.5 - 1)
    y[2] <- sign(numv) * r * sqrt(3) * abs(numv)
  }
  
  res <- matrix(c(cos(theta), sin(theta), -sin(theta), cos(theta)), nrow = 2) %*% rbind(x, y) + matrix(c(x0, y0, x0, y0), nrow = 2)
  res.ori <- matrix(c(cos(theta), sin(theta), -sin(theta), cos(theta)), nrow = 2) %*% c(x[1] + sign(numh) * r * 1/2, y[1] +  sign(numv) * r * sqrt(3)/2) + c(x0, y0)
  list(res.ori, res)
}

ellp_plot <- function(x0, y0, r, theta){
  rot <- matrix(c(cos(theta), sin(theta), -sin(theta), cos(theta)), nrow = 2)
  res <- rot %*% rbind(r * c(- 1/2, 1/2, 1, 1/2, -1/2, -1, -1/2), r * c(sqrt(3)/2, sqrt(3)/2, 0, -sqrt(3)/2, -sqrt(3)/2, 0, sqrt(3)/2))
  res <- rbind(rep(x0, 7), rep(y0 ,7)) + res
  x1 <- res[1,]
  y1 <- res[2,]
  lines(x1, y1)
} 

# 
a = 15
b = 7.5
r = 3.5
rep = 1000
th <- runif(rep, -30, 30)
th2 <- runif(rep, 0, 2 * pi)
rad_a <- runif(rep, 0, a/2)
rad_b <- runif(rep, 0, b/2)
rad_x0 <- rad_a * cos(th2)
rad_y0 <- rad_b * sin(th2)

re_min <- elli_pla(0, 0, 0, a, b,r)
ind_min <- 0
for (i in 1 : rep) {
  x0 <- rad_x0[i]
  y0 <- rad_y0[i]
  theta <- th[i]/180 *pi
  re <- elli_pla(x0, y0, theta, a, b,r)
  if(length(re[[1]]) < length(re_min[[1]])){
    re_min <- re
    ind_min <- i
  }
}

plot_th <- seq(0, 2*pi, 2*pi/50)
xx = a * cos(plot_th)
yy = b * sin(plot_th)
plot(xx, yy, type='l', xlim=c(-(a + 3), (a + 3)), ylim=c(-(a + 3), (a + 3)), 
     main = paste('ellipse with a =', a, ', b =', b, ', radius of needle is', r, '\n', 'theta is', round(th[ind_min], 1),'\n', ' start point is (', round(rad_x0[ind_min],1), ",", round(rad_y0[ind_min],2), ')'), xlab = 'X', ylab = 'Y', sub = paste('need to use', length(re_min[[1]]),'needles'))
points(rad_x0[ind_min], rad_y0[ind_min])
for (i in 1 : length(re_min[[1]])) {
  ellp_plot(re_min[[1]][i], re_min[[2]][i], r, th[ind_min]/180 * pi)
}


