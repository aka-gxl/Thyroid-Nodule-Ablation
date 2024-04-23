function [k, l] = elli_P_Tan(r, x0, y0, x1, y1, k0)
    % elli_P_Tan是给定点计算切线的函数，其中(x0, y0)是圆心，r是半径，(x1, y1)是引切线的点，k0时原直线的斜率
    syms kk
    eq = ((x0 - x1)^2 - r^2) * kk^2 - 2 * (x0 - x1) * (y0 - y1) * kk + (y0 - y1)^2 - r^2;
    k = solve(eq, kk);
    k = double(k);
    [~, ind2] =max(abs(k - k0));
    k = k(ind2);
    l = y1 - k * x1;
    