# Determine whether a needle insertion point can be used

one_point_deter <- function(a0, b0, theta, r0){
  a <- a0/2
  b <- b0/2
  r <- r0/2

  k <- tan(theta/180*pi)
  l <- -b - sqrt(k^2 + 1) * r


  th <- seq(0, 2 * pi, 2 * pi/100)
  x0 <- a * cos(th)
  y0 <- b * sin(th)
  plot(x0, y0, type = "l", xlim = c(-15, 15),  ylim = c(-15, 15))
  abline(l, k)


  a^2 * k^2 + b^2 - l^2 < 0
}

one_point_deter(30, 20, 15, 7)

# 判断左右径最小阈值
min_b_search <- function(a0, theta, r0){
  if(one_point_deter(a0, 0, theta, r0)){
    return('There is no threshold.')
  }else{
    b_st <- 0
    if(one_point_deter(a0, a0, theta, r0)){
      b_ed <- a0
    }else{
      b_ed <- 2 * a0
      while(!one_point_deter(a0, b_ed, theta, r0)){
        b_ed <- 2 * b_ed
      }
    }
    while (abs(b_st - b_ed) > 1e-05) {
      b_md <- (b_st + b_ed)/2
      if(one_point_deter(a0, b_md, theta, r0)){
        b_ed <- b_md
      }else{
        b_st <- b_md
      }
    }
    return(b_md)
  }
}


for(a in c(20, 30, 40, 50, 60, 70)){
  cat(min_b_search(a, 45, 7), "\n")
}


data <- readxl::read_xlsx("/Users/gaozhe/Desktop/data_one_point.xlsx", sheet = 2, col_names = F)
data <- cbind(data, rep(0, nrow(data)))
for (i in 1 : nrow(data)) {
  data[i, 4] <- one_point_deter(data[i, 1], data[i, 2], 30, 7)
}

k0 <- tan(15/180 *pi)
k1 <- tan(20/180 *pi)
r = 3.5
x0 <- seq(10, 30, 0.5)
y0 <- x0^2 * k0^2/(2 * r * sqrt(k0^2 + 1)) - sqrt(k0^2 + 1) *r/2
y1 <- x0^2 * k1^2/(2 * r * sqrt(k1^2 + 1)) - sqrt(k1^2 + 1) *r/2
data_plot <- cbind(c(x0, x0), c(y0, y1), c(rep("15", length(x0)), rep("20", length(x0))))
data_plot <- as.data.frame(data_plot)
colnames(data_plot) <- c("X", "Y", "group")
data_plot$X <- as.numeric(as.vector(data_plot$X))
data_plot$Y <- as.numeric(as.vector(data_plot$Y))


p1 <- ggplot(data = data_plot, aes(X, Y, col = group))
p1 + geom_line()

k0 <- tan(45/180 *pi)
x <- seq(10, 40, 2)
y <- seq(5, 30, 2)
data_res <- matrix(nrow = length(x), ncol =  length(y))
colnames(data_res) <- as.character(2 * y)
rownames(data_res) <- as.character(2 * x)
for (i in 1 : length(x)) {
  x1 <- x[i]
  y1 <- x1^2 * k0^2/(2 * r * sqrt(k0^2 + 1)) - sqrt(k0^2 + 1) *r/2
  data_res[i,] <- as.numeric(y > y1)
}
write.csv(file = "data_res.csv", data_res)

datas <- NULL
for(i in 1 : length(x)){
  temp <- matrix(nrow = length(y), ncol = 2)
  temp[,1] <- x[i]
  temp[,2] <- y
  datas <- rbind(datas, temp)
}
seq(15, 40, 2) * seq(5, 30, 2)


temp <- readxl::read_xlsx("/Users/gaozhe/Desktop/temp.xlsx", col_names = F)
temp1 <- matrix(as.matrix(as.data.frame(temp[,4])), nrow = 13)
temp1 <- t(temp1)


# Movable needle insertion

one_point_deter_alt <- function(a0, b0, r0, theta0, alpha.l, alpha.r){
  # a0 and b0 are parameters of the ellipse
  # r0 is the diameter of ablation
  # theta0 is the position of the insertion point, assuming insertion in the upper half-plane, theta0 ranges from 0 to 180
  # alpha.l and alpha.r are the angles limited on the left and right sides
  # Normalize the parameters first
  a <- a0/2
  b <- b0/2
  r <- r0/2
  x0 <- a * cos(theta0/180*pi)
  y0 <- b * sin(theta0/180*pi)

  k.l <- tan(alpha.l/180*pi)
  l.l <- y0 - k.l * x0 + sqrt(k.l^2 + 1) * r

  k.r <- tan(pi - alpha.r/180*pi)
  l.r <- y0 - k.r * x0 + sqrt(k.r^2 + 1) * r


  # abline(l.r, k.r)

  c(a^2 * k.l^2 + b^2 - l.l^2 < 0, a^2 * k.r^2 + b^2 - l.r^2 < 0)
}

# selectable arc length
arc.search <- function(a0, b0, r0, alpha.l, alpha.r, thresh = 1e-05, st = 0, ed = 180){
  mid <- st
  count <- 0

  while(ed - st > thresh){
    mid <- (st + ed)/2
    res <- one_point_deter_alt(a0, b0, r0, mid, alpha.l, alpha.r)
    if((res[1] > 0 & res[2] == 0) || (res[1] > 0 & res[2] > 0 & mid >= 90)){
      ed <- mid
    }else if((res[2] > 0 & res[1] == 0) || (res[1] > 0 & res[2] > 0 & mid < 90)){
      st <- mid
    }else{
      break
    }
  }
  if(mid < 90){
    mid <- st
  }else{
    mid <- ed
  }
  res <- one_point_deter_alt(a0, b0, r0, mid, alpha.l, alpha.r)
  if(res[1] * res[2] == 0){
    return(FALSE)
  }
  
  if(mid > 90){
    poi1 <- mid
    st <- 90
    ed <- 180
    mid <- st
    while(ed - st > thresh){
      mid <- (st + ed)/2
      res <- one_point_deter_alt(a0, b0, r0, mid, alpha.l, alpha.r)
      if(res[2] > 0){
        st <- mid
      }else{
        ed <- mid
      }
    }
    poi2 <- mid
  }else{
    poi2 <- mid
    st <- 0
    ed <- 90
    mid <- st
    while(ed - st > thresh){
      mid <- (st + ed)/2
      res <- one_point_deter_alt(a0, b0, r0, mid, alpha.l, alpha.r)
      if(res[1] > 0){
        ed <- mid
      }else{
        st <- mid
      }
  }
  poi1 <- mid
  }
  return(c(poi1, poi2))
}
one_point_deter_alt(13, 13, 7, 0,  65.62, 42.28)
arc.search(15, 15, 7,  65.62, 42.28)


data_res <- cbind(rep(seq(10, 50, 5), 9), as.vector(sapply(seq(10, 50, 5), function(c){rep(c, 9)})), rep(0, 81), rep(0, 81))
for(i in 1 : 81){
  data_res[i, 3 : 4] <- arc.search(data_res[i, 1], data_res[i, 2], 7, 65.62, 42.28, ed = 180)
}



## 
data <- readxl::read_xlsx("individuals.xlsx")
res <- matrix(nrow=nrow(data), ncol = 2)
for (i in 1 : 50) {
  if(length(arc.search(data[i, 1], data[i, 2], 7,  65.62, 42.28)) > 1){
    res[i,1] <- TRUE
  }else{
    res[i,1] <- FALSE
  }
  
  if(length(arc.search(data[i, 1], data[i, 2], 7,  62.83, 31.58)) > 1){
    res[i,2] <- TRUE
  }else{
    res[i,2] <- FALSE
  }
}
res <- cbind(res, rep(0, 1))
res[,3] <- ifelse(res[,1] + res[,2] > 0, 1, 2)
res[,4] <- ifelse(res[,1] + res[,2] > 1, 3, 2)


a = seq(10, 30, 2)
r = 3.5
k = tan(65.62/180*pi)
y = ((a/2)^2 * k^2 - (k^2 + 1)*r^2)/(2 * r * sqrt(k^2 +1)) *2
plot(a, y, type = "l", xlab = "上下径")
