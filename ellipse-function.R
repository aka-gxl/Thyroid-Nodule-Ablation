# 
a = 20
b = 10
r = 7
theta = 2 * pi/3
x0 = a * cos(theta)
y0 = b * sin(theta)
elli_Tan_fun <- function(x) { 
  f <- numeric(2) 					
  f[1] <-  (2 * a^4 * b^2 + a^4 * x[2]^2) * x[1]^2 - a^2 * b^2 * x[2]^2 + a^2 * b^4
  f[2] <-  (x0^2 - r^2) * x[1]^2 + 2 * x0 * x[1] * x[2] - 2 * y0 * x[2] - 2 * x0 * x[1] * y0 - r^2 + y0^2 + x[2]^2
  f 
} 

