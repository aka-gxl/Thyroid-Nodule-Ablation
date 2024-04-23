function [ed, num, cut_alt] = one_step_div(st, r, cut_alt0, re_p, re_num, type, num0)
    if(type == 1)
        ed = st + 2 * r;
        cut_alt = cut_alt0;
        temp = find(ed < re_p == 1);
        temp_ind = temp(1);
        num =  num0 + re_num(temp_ind);
    end
    
    if(type == 2)
        temp = find(st + 2 * r < re_p == 1);
        temp_ind = temp(1) - 1;
        if(st + 2 * r > re_p(temp_ind) && st + 2 * r - re_p(temp_ind) < cut_alt0)
            ed = re_p(temp_ind);
            cut_alt = cut_alt0 - (st + 2 * r - re_p(temp_ind));
            num =  num0 + re_num(temp_ind);
        else
            ed = st + 2 * r;
            cut_alt = cut_alt0;
            temp = find(ed < re_p == 1);
            temp_ind = temp(1);
            num =  num0 + re_num(temp_ind);
        end
    end