function [K, L, L1, kf] =  elli_Plane_fun(a, b, r, x0, y0)
%     x0 = a * cos(theta);
%     y0 = b * sin(theta);
    
    % 计算切线
    syms k l
    f(1) =  a^2 * k^2  -  l^2 + b^2;
    f(2) =  (x0^2 - r^2) * k^2 + l^2 +  2 * x0 * k * l - 2 * y0 * l - 2 * x0 * k * y0 - r^2 + y0^2;

    [ell_k, ell_l] = solve(f(1), f(2), k, l);

    ell_k = double(ell_k);
    ell_l = double(ell_l);

    ind = find(imag(double(ell_k)) == 0);
    
    % k0和l0是两条切线的参数
    k0 = ell_k(ind);
    l0 = ell_l(ind);
    
    % 求解切点
    g(1) = k0(1) * k - l + l0(1);
    g(2) = k0(1) * (l - y0) + k - x0;
    
    [TPx1, TPy1] = solve(g(1), g(2), k, l);
    
    g(3) = k0(2) * k - l + l0(2);
    g(4) = k0(2) * (l - y0) + k - x0;
    
    [TPx2, TPy2] = solve(g(3), g(4), k, l);
    
    [deta1, ~] = cart2pol(double(TPx1) - x0, double(TPy1) - y0);
    [deta2, ~] = cart2pol(double(TPx2) - x0, double(TPy2) - y0);
    
    if(deta1 < 0)
        deta1 = deta1 * 180/pi + 360;
    else
        deta1 = deta1 * 180/pi;
    end
    
    if(deta2 < 0)
        deta2 = deta2 * 180/pi + 360;
    else
        deta2 = deta2 * 180/pi;
    end

    % 循环求解
    if(deta1 > deta2)
        k1 = k0(1);
        l1 = l0(1);
        kf = k0(2);
    else
        k1 = k0(2);
        l1 = l0(2);
        kf = k0(1);
    end
    
    
    
    K = [];
    L = [];
    L1 = [];
    X = [];
    Y = [];
    K(1) = k1;
    L(1) = l1;

    i = 1;
    % 判断条件选择
    if((k1 * kf < 0 && (deta1 - 90) * (deta2 - 90) < 0 && deta1 <= 180))
        
        while((K(i) > 0 && K(i) >= abs(k1)) || (K(i) < kf))
            if(K(i) > 0 && length(K) > 5)
                type = 2;
            else
                type = 1;
            end
            [X(i), Y(i), L1(i)] = elli_Tan_P(K(i), L(i), a, b, r, type);
            [K(i + 1), L(i + 1)] = elli_P_Tan(r, x0, y0, X(i), Y(i), K(i));
            i = i + 1;
        end
    elseif(k1 > 0 && kf > 0)
        
        while(K(i) < kf || (K(i) >= k1 && length(K) < 5))
            if(K(i) > 0 && length(K) < 5)
                type = 1;
            else
                type = 2;
            end
            [X(i), Y(i), L1(i)] = elli_Tan_P(K(i), L(i), a, b, r, type);
            [K(i + 1), L(i + 1)] = elli_P_Tan(r, x0, y0, X(i), Y(i), K(i));
            i = i + 1;
        end
    else
        type = 2;
        while(K(i) < kf)
            [X(i), Y(i), L1(i)] = elli_Tan_P(K(i), L(i), a, b, r, type);
            [K(i + 1), L(i + 1)] = elli_P_Tan(r, x0, y0, X(i), Y(i), K(i));
            i = i + 1;
        end
    end
    
    L1(i) = L(i) + 2 * r/(cos(atan(K(i))));