clear
a = 21/2;
b = 15/2;
c = 17/2;
r = 3.5;
rs = r/sqrt(2);
theta = 155;
th = 0 : 2*pi/99 : 2*pi;

% 第一步分割
div_num = ceil(a/rs);
cut_alt = div_num * rs - a;

% 确定分割位置
% 可移动长度 cut_point(length(cut_point)) - a
[m_max, re_poi] = elli_pla_div(a, b, c, r, theta, 1e-03);
%re_poi = a - re_poi;
re_poi1 = [-re_poi, fliplr(re_poi), 100];
re_num = [1 : m_max, fliplr(1 : (m_max - 1))];
    
[ed, cut_point, cut_alt, all_num] = cut_decide(-a, rs, cut_alt, re_poi1, re_num, div_num);
% 
% for i = 1 : num/2
%     if(div(i) + rs - re_poi(1) < cut_alt && div(i) + rs - re_poi(1) > 0)
%         div(i + 1) = re_poi(1);
%         cut_alt = cut_alt - (div(i) + rs - re_poi(1));
%     else
%         div(i + 1) = div(i) + rs;
%     end
%     
% end
%         

cut_point(length(cut_point)) = a;
num = [];
aa = 0;
bb = 0;



% 绘图
close all
figure(1)
th = 0 : 2*pi/99 : 2*pi;
x = a * cos(th);
y = b * sin(th);

plot(x, y)
hold on

for i = 1 : length(cut_point)
    x1 = [cut_point(i), cut_point(i)];
    y = [-b, b];
    plot(x1, y)
    hold on
end
axis([-(a + 5), (a + 5), -(a + 5), (a + 5)])


for i = 1 : (length(cut_point) - 1)
    KK = [];
    LL = [];
    LL1 = [];
    
    st = cut_point(i);
    ed = cut_point(i + 1);

    [KK, LL, LL1, aa, bb] =  circle_pl(a, b, c, st, ed, r, theta);
    num(i) = length(KK);

    figure(i + 1)
    xt = aa * cos(th);
    yt = bb * sin(th);

    xct = r * cos(th) + aa * cos(theta * pi/180);
    yct = r * sin(th) + bb * sin(theta * pi/180);
    plot(xt, yt, 'r')
    hold on
    plot(xct, yct, 'b')
    hold on

    x1 = [-(aa + 5), aa + 5];
    for j = 1 : length(KK)
        y = KK(j) .* x1 + LL(j);
        y1 = KK(j) .* x1 + LL1(j);
        plot(x1, y, x1, y1)
        hold on
    end
    plot(aa * cos(theta * pi/180), bb * sin(theta * pi/180), 's', 'MarkerSize', 10)
    title(['第', num2str(i), '个截面示意图,共需要调整', num2str(length(KK)), '次'])
    axis([-(aa + 5), aa + 5, -(aa + 5), aa + 5])
    save(['data', num2str(i), '.mat'], 'KK', 'LL', 'LL1')
end

disp(['共需要', num2str((length(cut_point) - 1)), '个入针点'])
disp(['各自需要调整', num2str(num), '针'])
disp(['一共需要调整：', num2str(sum(num)), '针'])
save('data.mat', 'cut_point', 'KK', 'LL', 'LL1')