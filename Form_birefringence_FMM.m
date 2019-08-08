function [R_TE,R_TM]=Form_birefringence_FMM(lambda, n1, n2, ni, nt, f, d, t)


        the = 0; %input angle
        do = -40:40; %diffraction orders in FMM calculation
        tpl = [f 1]; %material edges
        diff_ord = (length(do)-1)/2+1;   % m=0 diffraction order
        
        
        eta_m1_TE=zeros(size(t));
        eta_m1_TM=zeros(size(t));
%         for ind_t = 1:length(t)
        zl = [0 t];
        nl = [n1 n2]; %

        [re_TE,te_TE]=eigml_te(ni,nt,nl,the,lambda,d,zl,do,tpl);
        [re_TM,te_TM]=eigml_tm(ni,nt,nl,the,lambda,d,zl,do,tpl);
        R_TE=re_TE(diff_ord);
        R_TM=re_TM(diff_ord);
