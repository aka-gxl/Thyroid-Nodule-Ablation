% »­Í¼
a = aa;
b = bb;
r = 3.5;
theta = 175 * pi/180;
% x0 = a * cos(theta);
% y0 = b * sin(theta);
% ratio = 1.5;
% theta =  150/180 * pi;
% num = 1;
% err = 1e-06;
% [m, KK, LL, LL1, iter] = max_elli(ratio, r, theta, num, err);

ratio = 1.5;
% num = 2;
% theta = 135/180 * pi;
% m = elli_pla_max_enter(ratio, r, num, theta, 1e-06);
% [KK, LL, LL1, ~] =  elli_Plane_fun(ratio * m, m, r, ratio * m * cos(theta), m * sin(theta));

th = 0 : 2*pi/99 : 2*pi;
x = aa * cos(th);
y = bb * sin(th);

xc = r * cos(th) + aa * cos(theta);
yc = r * sin(th) + bb * sin(theta) ;



x1 = [-20, 20];
%y1 = k(1) .* x1 + l(1);
% y1 = k .* x1 + l - 2 * r/(cos(atan(k)));
% y2 = k .* x1 + l;
% y3 = K(i) .* x1 + L(i);
hold on 
plot(x,y,xc, yc)
for i = 1 : length(KK)
    y = KK(i) .* x1 + LL(i);
    y1 = KK(i) .* x1 + LL1(i);
    plot(x1, y,x1,y1)
    hold on
end
% yf = K(1) * xf + L1(1);
% plot(X(1 : 4), Y(1: 4), 's', 'MarkerSize', 10)
%hold on 
%plot(x1, y3)

axis([-10, 10, -10, 10])