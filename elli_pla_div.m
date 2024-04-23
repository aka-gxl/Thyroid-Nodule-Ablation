function [m_max, re_poi] = elli_pla_div(a, b, c, r, theta, err)
    % elli_pla_div给出了椭圆上划分的针数临界点
    th = theta * pi/180;
    x0 = b * cos(th);
    y0 = c * sin(th);
    [KK, ~, ~, ~] =  elli_Plane_fun(b, c, r, x0, y0);
    m_max = length(KK);
    re_poi = [];
    for i = 1 : (m_max - 1)
        [m, ~, ~, ~, ~] = max_elli(b/c, r, th, i, err);
        xx = a * sqrt(1 - m^2/c^2);
        re_poi(i) = xx;
    end

 