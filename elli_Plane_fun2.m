function [K, L, L1] =  elli_Plane_fun2(a, b, r, x0, theta)
    % 循环求解
    K = [];
    L = [];
    L1 = [];
    X = [];
    Y = [];
    K(1) = tan(theta);
    L(1) = (-x0 + r/sin(atan(K(1)))) * K(1);
    
   
    
    
    
    syms xx2
    eq = (b^2 + a^2 * K(1)^2) * xx2^2 + 2 * a^2 * K(1) * L(1) * xx2 + a^2 * (L(1)^2 - b^2);
    xx = solve(eq, xx2);
    xx = double(xx);
    xx = max(xx);
    yy = K(1) * xx + L(1);
    
    [deta, ~] = cart2pol(xx, yy);
    
    [X(1), Y(1), L1(1)] = elli_Tan_P2(K(1), L(1), a, b, r, x0, deta);
    %[K(2), L(2)] = elli_P_Tan(r, x0, 0, X(1), Y(1), K(1));
    
    % 求解停止点
    syms xx3
    eq = (b^2 + a^2 * K(1)^2) * xx3^2 + 2 * a^2 * K(1) * L1(1) * xx3 + a^2 * (L1(1)^2 - b^2);
    xx1 = solve(eq, xx3);
    xx1 = double(xx1);
    xf = min(xx1);
    
    i = 1;
    while(X(i) >= xf)
        [K(i + 1), L(i + 1)] = elli_P_Tan(r, x0, 0, X(i), Y(i), K(i));
        i = i + 1;
        [deta, ~] = cart2pol(X(i-1), Y(i-1));
        [X(i), Y(i), L1(i)] = elli_Tan_P2(K(i), L(i), a, b, r, x0, deta);
        
    end
    xo = -(K(i) * L(i) - x0)/(K(i)^2 + 1);
    yo = K(i) * xo + L(i);
    L1(i) = L(i) - 2 * sign(yo) *  r/(cos(atan(K(i))));