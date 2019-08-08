clear
close all

omega_0=1;
Gamma_0=1;
 T_e=3;
 T_p=0.1;
%T_e=3;
%T_p=10;

t=linspace(-20,20,500);
Delta_t=t*2;

set (0, 'defaultaxesfontname', 'Helvetica')
set (0, 'defaultaxesfontsize', 14)
set (0, 'defaulttextfontname', 'Helvetica')
set (0, 'defaulttextfontsize', 14) 



[t_1,t_2]=meshgrid(t,t);

T=T_e*sqrt(1+T_p^2/T_e^2);
Theta=T_e*sqrt(1+T_e^2/T_p^2);

Gamma=Gamma_0*exp(-(t_1.^2+t_2.^2)/T.^2).*exp(-(t_1-t_2).^2/(2*Theta^2))...
      .*exp(-1i*omega_0*(t_1-t_2));
      
gamma=exp(-(t_1-t_2).^2/(2*Theta^2))...
      .*exp(-1i*omega_0*(t_1-t_2));

gamma_Delta_t=exp(-(Delta_t).^2/(2*Theta^2))...
      .*exp(-1i*omega_0*(Delta_t));
      
I=Gamma_0*exp(-2*t.^2/T.^2);

I_ref=Gamma_0*exp(-2*t.^2/T_e.^2);

gamma_ref=exp(-Delta_t.^2/(2*T_e.^2));

figure
subplot(2,2,1)
hold on
plot(t,I,'linewidth',1.5)
plot(t,I_ref, 'r--','linewidth',1.5)
xlabel('t')
ylabel('I(t)')

title(['\omega_0=',num2str(omega_0), ', \Gamma_0=',num2str(Gamma_0),...
 ', T_e=',num2str(T_e), ', T_p=',num2str(T_p)])
legend('I(t)','\Gamma_0 exp[-2 t^2/(T_e)]','Location','northoutside')


subplot(2,2,2)
hold on
plot(Delta_t,abs(gamma_Delta_t),'linewidth',1.5)
plot(Delta_t,gamma_ref, 'r--','linewidth',1.5)
xlabel('\Delta t')
ylabel('\gamma(\Delta t)')
legend('\gamma(\Delta t)','exp[-\Deltat^2/(2 T_e)]','Location','northoutside')


subplot(2,2,3)
imagesc(t,t,abs(Gamma));
axis equal; axis xy; axis tight;
colorbar
title('|\Gamma(t_1,t_2)|')
xlabel('t_1')
ylabel('t_2')


subplot(2,2,4)
imagesc(t,t,abs(gamma));
axis equal; axis xy; axis tight;
colorbar
title('|\gamma(t_1,t_2)|')
xlabel('t_1')
ylabel('t_2')

