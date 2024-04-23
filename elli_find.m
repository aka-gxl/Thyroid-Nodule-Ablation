function [aa, bb] = elli_find(a, b, c, k, l)
    aa = sqrt((1 + a^2 * k^2 * l^2/(b^4 + a^2 * k^2 * b^2) - l^2/b^2)/(1/a^2 + k^2/b^2) * (1 + k^2));
    bb = sqrt(c^2 * (1 + a^2 * k^2 * l^2/(b^4 + a^2 * k^2 * b^2) - l^2/b^2));