clear
close all

TE_limit=0.2; % plotting limit
TM_limit=1; % plotting limit

use_FMM=0;

n1=1;  % first refractive index in grating
n2=1.45+1i*7.54; % second refractive index in grating
ni=1.5; % refractive index before grating
nt=1; % refractive index after grating
lambda=1; % wavelength

d=lambda/4; % period for FMM
the = 0; % input angle
N_do=30; % number of diffractive orders in FMM calculation

f_v=linspace(0,1,300); % fill factors in the first figure
f=0.5;  % fill factor in the second figure
t=linspace(0,1,200); % grating heights

linewidth=1.5;


k_0=2*pi/lambda; 

N_TE_v=sqrt(n1.^2*f_v+n2.^2*(1-f_v));
N_TM_v=n1.*n2./sqrt(n2.^2*f_v+n1.^2*(1-f_v));

N_TE=sqrt(n1.^2*f+n2.^2*(1-f));
N_TM=n1.*n2./sqrt(n2.^2*f+n1.^2*(1-f));

Phi_TE=k_0 .* N_TE .* t;
Phi_TM=k_0 .* N_TM .* t;

R_TE=abs((N_TE.*(ni-nt).*cos(Phi_TE) - 1i.*(ni.*nt-N_TE.^2).*sin(Phi_TE))./...
         (N_TE.*(ni+nt).*cos(Phi_TE) - 1i.*(ni.*nt+N_TE.^2).*sin(Phi_TE))).^2;
     
R_TM=abs((N_TM.*(ni-nt).*cos(Phi_TM) - 1i.*(ni.*nt-N_TM.^2).*sin(Phi_TM))./...
         (N_TM.*(ni+nt).*cos(Phi_TM) - 1i.*(ni.*nt+N_TM.^2).*sin(Phi_TM))).^2;   

T_TE=nt/ni.*abs((2*ni*N_TE)./...
         (N_TE.*(ni+nt).*cos(Phi_TE) - 1i.*(ni.*nt+N_TE.^2).*sin(Phi_TE))).^2;
     
T_TM=nt/ni.*abs((2*ni*N_TM)./...
         (N_TM.*(ni+nt).*cos(Phi_TM) - 1i.*(ni.*nt+N_TM.^2).*sin(Phi_TM))).^2;     
     
A_TE=1-R_TE-T_TE;
A_TM=1-R_TM-T_TM;
     

if(use_FMM==1)
    
    d_o = -N_do:1:N_do; %diffraction orders in FMM calculation
    tpl = [f 1]; %material edges
    diff_ord = (length(d_o)-1)/2+1;   % 0 diffraction order
    nl = [n1, n2]; % refractive indeces in the grating layer

    R_TE_FMM=zeros(size(t));
    R_TM_FMM=zeros(size(t));
    T_TE_FMM=zeros(size(t));
    T_TM_FMM=zeros(size(t));
    A_TE_FMM=zeros(size(t));
    A_TM_FMM=zeros(size(t));
    
    for ind_t = 1:length(t)
        zl = [0 t(ind_t)]; %layer starting points
        [re_TE,te_TE]=eigml_te(ni, nt, nl, the, lambda, d, zl, d_o, tpl);
        [re_TM,te_TM]=eigml_tm(ni, nt, nl, the, lambda, d, zl, d_o, tpl);
        R_TE_FMM(ind_t)=re_TE(diff_ord);
        R_TM_FMM(ind_t)=re_TM(diff_ord);
        T_TE_FMM(ind_t)=te_TE(diff_ord);
        T_TM_FMM(ind_t)=te_TM(diff_ord);
        A_TE_FMM(ind_t)=1-R_TE_FMM(ind_t)-T_TE_FMM(ind_t);
        A_TM_FMM(ind_t)=1-R_TM_FMM(ind_t)-T_TM_FMM(ind_t);
     
    end
end



figure
subplot(2,2,1)
plot(f_v,real(N_TE_v));
xlabel('f')
ylabel('real(N_{TE})')

subplot(2,2,2)
plot(f_v,real(N_TM_v));
xlabel('f')
ylabel('real(N_{TM})')

subplot(2,2,3)
plot(f_v,imag(N_TE_v));
xlabel('f')
ylabel('imag(N_{TE})')

subplot(2,2,4)
plot(f_v,imag(N_TM_v));
xlabel('f')
ylabel('imag(N_{TM})')


% z_1_per_e2_TM=1./(2*imag(N_TM));
% z_1_per_e2_TE=1./(2*imag(N_TE));
% 
% figure
% subplot(1,2,1)
% hold on
% plot(f_v,z_1_per_e2_TE,'r','linewidth',linewidth);
% % plot(f,z_1_per_e2_TM,'b');
% % legend('TE','TM')
% xlabel('f')
% ylabel('z_{1/e^2}_{TE}')
% axis([0,1,0,3])
% 
% hold on
% subplot(1,2,2)
% % plot(f,z_1_per_e2_TE,'r','linewidth',linewidth);
% plot(f_v,z_1_per_e2_TM,'b');
% % legend('TE','TM')
% xlabel('f')
% ylabel('z_{1/e^2}_{}TM')
% axis([0,1,0,500])

figure
subplot(3,2,1)
hold on
plot(t, R_TE,'r','linewidth',linewidth);

if(use_FMM==1)
    plot(t, R_TE_FMM,'b-.','linewidth',linewidth);  
    legend('effective indices','FMM','location','southeast')
    title(['TE, f = ', num2str(f), ', period = ', num2str(d/lambda),'\lambda'])
else
    title(['TE, f = ', num2str(f)])
end
xlabel('t / \lambda_0')
ylabel('R','linewidth',linewidth)
xlim([0,TE_limit])


subplot(3,2,2)
hold on
plot(t, R_TM,'r','linewidth',linewidth);
if(use_FMM==1)
    plot(t, R_TM_FMM,'b-.','linewidth',linewidth);   
end
xlabel('t / \lambda_0')
ylabel('r','linewidth',linewidth)
xlim([0,TM_limit])
title('TM')

subplot(3,2,3)
hold on
plot(t, T_TE,'r','linewidth',linewidth);
if(use_FMM==1)
    plot(t, T_TE_FMM,'b-.','linewidth',linewidth);
end
xlabel('t / \lambda_0')
ylabel('T')
xlim([0,TM_limit])
xlim([0,TE_limit])

subplot(3,2,4)
hold on
plot(t, T_TM,'r','linewidth',linewidth);
if(use_FMM==1)
    plot(t, T_TM_FMM,'b-.','linewidth',linewidth);
end
xlim([0,TM_limit])
xlabel('t / \lambda_0')
ylabel('T')

subplot(3,2,5)
hold on
plot(t, A_TE,'r','linewidth',linewidth);
if(use_FMM==1)
    plot(t, A_TE_FMM,'b-.','linewidth',linewidth);
end
xlabel('t / \lambda_0')
ylabel('A')
xlim([0,TE_limit])

subplot(3,2,6)
hold on
plot(t, A_TM,'r','linewidth',linewidth);
if(use_FMM==1)
    plot(t, A_TM_FMM,'b-.','linewidth',linewidth);
end
xlim([0,TM_limit])
xlabel('t / \lambda_0')
ylabel('A')


