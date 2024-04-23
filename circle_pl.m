function [KK, LL, LL1, aa, bb] = circle_pl(a, b, c, st, ed, r, theta)
    if(st * ed < 0)
        m = 0;
    else
        m = min(abs(st), abs(ed));
    end
    
    aa = sqrt(1 - m^2/a^2) * b;
    bb = sqrt(1 - m^2/a^2) * c;
    
    X0 = aa * cos(theta * pi/180);
    Y0 = bb * sin(theta * pi/180);
    
    [KK, LL, LL1, ~] =  elli_Plane_fun(aa, bb, r, X0, Y0);