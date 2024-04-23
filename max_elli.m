function [m, KK, LL, LL1, iter] = max_elli(ratio, r, theta, num, err)
    % max_elli ��Ѱ�Ҹ���������Ĵ�����������Բ
    % ratio ����Բ����Ͷ���ıȣ�r����İ뾶��theta������ĽǶȣ�num����ĵ�������
    KK = [1,2];
    LL = [];
    LL1 = [];
    kf = 0;
    st = 0.5 * r;
    ed = (num + 1) * r;
    iter = 0;
    while(abs(KK(length(KK)) - kf) > err)
        temp = (st + ed)/2;
        bb = temp;
        aa = ratio * temp;
        x0 = aa * cos(theta);
        y0 = bb * sin(theta);
        [KK, LL, LL1, kf] =  elli_Plane_fun(aa, bb, r, x0, y0);
        if(length(KK) <= num)
            st = temp;
        else
            ed = temp;
        end
        m = temp;
        iter = iter + 1;
    end
   
    