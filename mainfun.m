a = 15;
b = 7.5;
c = 7.5
r = 3.5;
rs = r/sqrt(2);
x0 = - 0.5;

color=[1 0 0;0 1 0;0 0 1;1 0.5 1; 0.5 0 0;0 0.5 0;1 0.5 0.5; 0.5 1 0.5;0.5 0.5 1;1 1 0;0 1 1;1 0 1];

%clear
close all
% 计算椭圆切线

A = [];
B = [];

[K, L, L1, ~] =  elli_Plane_fun(a, b, rs, 0, b);
%[K, L, L1] =  elli_Plane_fun2(a, b, rs, x0, theta);

% 绘图1
figure(1)
th = 0 : 2*pi/99 : 2*pi;
x = a * cos(th);
y = b * sin(th);

xc = rs * cos(th);
yc = rs * sin(th) + b;


plot(x, y, xc, yc)
hold on
x1 = [-20, 20];
for i = 1 : length(K)
y = K(i) .* x1 + L(i);
y1 = K(i) .* x1 + L1(i);
plot(x1, y, x1, y1, 'color', color(i,:))
hold on
end
axis([-15, 15, -15, 15])
num = [];
for i = 1 : length(K)
KK = [];
LL = [];
LL1 = [];
X0 = 0;
Y0 = 0;
if((L(i) * L1(i) < 0))
    [A(i), B(i)] = elli_find(a, b, c, K(i), 0);
else
    [A(i), B(i)] = elli_find(a, b, c, K(i), min(L(i), L1(i)));
end

[KK, LL, LL1, ~] =  elli_Plane_fun(A(i), B(i), r, -A(i), 0);
num(i) = length(KK);

figure(i + 1)
xt = A(i) * cos(th);
yt = B(i) * sin(th);

xct = r * cos(th) - A(i);
yct = r * sin(th);
plot(xt, yt, 'r')
hold on
plot(xct, yct, 'g')
hold on

x1 = [-20, 20];
for j = 1 : length(KK)
    y = KK(j) .* x1 + LL(j);
    y1 = KK(j) .* x1 + LL1(j);
    plot(x1, y, x1, y1)
    hold on
end
plot(X0, Y0, 's', 'MarkerSize', 10)
axis([-15, 15, -15, 15])
end
%rep_num(s) = sum(num);


disp(['各自需要', num2str(num)])
disp(['一共需要：', num2str(sum(num))])
