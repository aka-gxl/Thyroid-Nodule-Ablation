function [k, l] = elli_P_Tan(r, x0, y0, x1, y1, k0)
    % elli_P_Tan�Ǹ�����������ߵĺ���������(x0, y0)��Բ�ģ�r�ǰ뾶��(x1, y1)�������ߵĵ㣬k0ʱԭֱ�ߵ�б��
    syms kk
    eq = ((x0 - x1)^2 - r^2) * kk^2 - 2 * (x0 - x1) * (y0 - y1) * kk + (y0 - y1)^2 - r^2;
    k = solve(eq, kk);
    k = double(k);
    [~, ind2] =max(abs(k - k0));
    k = k(ind2);
    l = y1 - k * x1;
    