function [ed, div, cut_alt, all_num] = cut_decide(st, r, cut_alt00, re_p, re_num, n)
    
    if(n == 0)
        ed = st;
        div = st;
        cut_alt = cut_alt00;
        all_num = 0;
    end
    
    if(n >= 1)
        [ed0, div, cut_alt0, all_num0] = cut_decide(st, r, cut_alt00, re_p, re_num, n - 1);

        [ed1, all_num1, cut_alt1] = one_step_div(ed0, r, cut_alt0, re_p, re_num, 1, all_num0);
        [ed2, all_num2, cut_alt2] = one_step_div(ed0, r, cut_alt0, re_p, re_num, 2, all_num0);

        if(all_num1 <= all_num2)
            ed = ed1;
            cut_alt = cut_alt1;
            all_num = all_num1;
        else
            ed = ed2;
            cut_alt = cut_alt2;
            all_num = all_num2;
        end


        div = [div, ed];
    end