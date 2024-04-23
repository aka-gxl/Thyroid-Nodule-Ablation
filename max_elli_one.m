function temp = max_elli_one(a, b, r, err)
    ratio = a/b;
    K = [];
    st = b;
    ed = 2 * b;
    temp = 2 * b;
    while(abs(temp - st) > err)
        temp = (st + ed)/2;
        aa = temp * ratio;
        bb = temp;
        [K, ~, ~, ~] =  elli_Plane_fun(aa, bb, r, 0, bb);
        if(K(1) < 1/sqrt(3))
            ed = temp;
        else
            st = temp;
        end
    end