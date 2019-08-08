clear
close all

f=0.5;
% f_v=linspace(0,1,300);
f_v=linspace(0.2, 0.8, 300);



n1=linspace(1.38, 3.5, 1000);
% n1=linspace(1.38, 2, 1000);
n2=1;
ni=1.5;
nt=1.0;

n1_v=[1.5, 2, 3.5];


lambda=1;

[N_TE,N_TM,t,Phi_TE,Phi_TM,R_TE,R_TM, R_TE_per_R_TM]=Form_birefringence(lambda, n1, n2, ni, nt, f);
  
figure
subplot(2,1,1)
hold on
plot(n1, N_TE,'r');
plot(n1, N_TM,'b');
legend('N_{TE}', 'N_{TM}','location','northwest')
xlim([min(n1), max(n1)])
xlabel('n_1')
ylabel('N')

subplot(2,1,2)
hold on
plot(n1, t./lambda,'r');
xlim([min(n1), max(n1)])
xlabel('n_1')
ylabel('t/\lambda_0')

figure
hold on
plot(n1, R_TE,'r');
plot(n1, R_TM,'b');
legend('R_{TE}', 'R_{TM}','location','northwest')
xlim([min(n1), max(n1)])
xlabel('n_1')
ylabel('R')

figure
for ind_n1=1:length(n1_v)
    n1_a=n1_v(ind_n1);
    
    [N_TE_a, N_TM_a, t_a, Phi_TE_a, Phi_TM_a, R_TE_a, R_TM_a, R_TE_per_R_TM_a]=Form_birefringence(lambda, n1_a, n2, ni, nt, f_v);
    
    subplot(length(n1_v),1,ind_n1)
    hold on
    plot(f_v, R_TE_a,'r');
    plot(f_v, R_TM_a,'b');
    legend('R_{TE}', 'R_{TM}','location','northwest')
    xlim([min(f_v), max(f_v)])
    xlabel('f')
    ylabel('R')
    title(['n_1 = ', num2str(n1_a)])
end