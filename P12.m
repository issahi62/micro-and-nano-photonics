close all
clear

L_x=100;
lambda_0=0.67;

Nmodes=5;

colors='krgbcmy';

x=linspace(-70,70,500);
k_x=linspace(-0.4,0.4,500);
theta=asind(k_x.*lambda_0./(2*pi));

intensity=zeros(size(x));
angular_intensity=zeros(size(k_x));

legend_text={};

source_figure=figure;
subplot(3,1,1)
subplot(3,1,2)
subplot(3,1,3)
kx_figure=figure;
theta_figure=figure;

myXlim=[-60,90];

%for m=1:Nmodes
for m=1:Nmodes
% for m=8:Nmodes
    if(mod(m,2)==0) %even
        V_m=sqrt(2/L_x)*sin(pi*m*x/L_x);
        A_m=1i*m*(-1)^(m/2)*sqrt(2*L_x)*sin(k_x*L_x/2)./(pi^2*m^2-k_x.^2*L_x.^2);
    elseif(mod(m,2)==1) %odd
        V_m=sqrt(2/L_x)*cos(pi*m*x/L_x);
        A_m=m*(-1)^((m-1)/2)*sqrt(2*L_x)*cos(k_x*L_x/2)./(pi^2*m^2-k_x.^2*L_x.^2);
    end    
    V_m(abs(x)>L_x/2)=0;
    
    intensity=intensity+abs(V_m).^2;
    angular_intensity=angular_intensity+abs(A_m).^2;
    
    figure(source_figure)
    subplot(3,1,1)   
    plot(x, V_m, colors(m))

    hold on
    subplot(3,1,2)
    hold on
    plot(x, abs(V_m).^2, colors(m))
    
    figure(kx_figure)
    subplot(3,1,1)
    hold on
    plot(k_x, real(A_m), [colors(m),'-'])
    plot(k_x, imag(A_m), [colors(m),'--'])
    subplot(3,1,2)
    hold on
    plot(k_x, abs(A_m).^2, colors(m))
    
    figure(theta_figure)
    subplot(3,1,1)
    hold on
    plot(theta, real(A_m), [colors(m),'-'])
    plot(theta, imag(A_m), [colors(m),'--'])
    subplot(3,1,2)
    hold on
    plot(theta, abs(A_m).^2, colors(m))
    
    
    
    legend_text{m}=['m = ',num2str(m)];
end

figure(source_figure)
subplot(3,1,1)
xlabel('x')
ylabel('V_m')
xlim(myXlim)
subplot(3,1,2)
xlabel('x')
ylabel('|V_m|^2')
xlim(myXlim)
subplot(3,1,3)
hold on
plot(x, intensity, 'k')
xlabel('x')
ylabel('I(x)')
xlim(myXlim)

figure(kx_figure)
subplot(3,1,1)
xlabel('k_x')
ylabel('A_m')
title('solid line: real part, dashed line: imaginary part')
subplot(3,1,2)
xlabel('k_x')
ylabel('|A_m|^2')
subplot(3,1,3)
hold on
xlabel('k_x')
ylabel('I_A(k_x)')
plot(k_x, angular_intensity, 'k')


figure(theta_figure)
subplot(3,1,1)
xlabel('\theta [degrees]')
ylabel('A_m')
title('solid line: real part, dashed line: imaginary part')

subplot(3,1,2)
xlabel('\theta [degrees]')
ylabel('|A_m|^2')
subplot(3,1,3)
hold on
plot(theta, angular_intensity, 'k')
ylabel('I_A(\theta)')
xlabel('\theta [degrees]')

figure(source_figure)
subplot(3,1,1)
legend(legend_text)