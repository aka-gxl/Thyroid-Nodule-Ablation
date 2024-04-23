function [x1, y1, l1] = elli_Tan_P2(k, l, a, b, r, x0, deta)
    % elli_Tan_P�Ǹ���һ�����ߣ������һ����������Բ�Ľ��㡣k��l�Ǹ���һ�����ߵ�б���Լ��ؾ࣬a��b����Բ�Ĳ�����r��Բ�İ뾶
    xo = -(k * l - x0)/(k^2 + 1);
    yo = k * xo + l;
    l1 = l - 2 * sign(yo) * r / (cos(atan(k)));
    deta1 = [];
    syms xx
    eq = (b^2 + a^2 * k^2) * xx^2 + 2 * a^2 * k * l1 * xx + a^2 * (l1^2 - b^2);
    x = solve(eq, xx);
    x = double(x);
    y = k * x + l1; 
    [deta1(1), ~] = cart2pol(x(1), y(1));
    [deta1(2), ~] = cart2pol(x(2), y(2));
    if(deta1(1) > 0 && deta1(2) > 0)
        [~, ind] = max(abs(deta1 - deta));
    else
        [~, ind] = min(abs(deta1 - deta));
    end
    x1 = x(ind);
    y1 = y(ind);
