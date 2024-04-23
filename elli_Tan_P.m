function [x1, y1, l1] = elli_Tan_P(k, l, a, b, r, type)
    % elli_Tan_P�Ǹ���һ�����ߣ������һ����������Բ�Ľ��㡣k��l�Ǹ���һ�����ߵ�б���Լ��ؾ࣬a��b����Բ�Ĳ�����r��Բ�İ뾶
    if(type == 1)
        l1 = l - 2 * sign(k) * r/(cos(atan(k)));
    else
        l1 = l + 2 *  r/(cos(atan(k)));
    end
    syms xx
    eq = (b^2 + a^2 * k^2) * xx^2 + 2 * a^2 * k * l1 * xx + a^2 * (l1^2 - b^2);
    x = solve(eq, xx);
    x = double(x);
    y = k * x + l1; 
    [deta1, ~] = cart2pol(x(1)/a, y(1)/b);
    [deta2, ~] = cart2pol(x(2)/a, y(2)/b);
    
    
    if(deta1 > deta2)
        x1 = x(2);
        y1 = y(2);
    else
        x1 = x(1);
        y1 = y(1);
    end
  
    