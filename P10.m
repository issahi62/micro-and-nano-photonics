clear

phase=linspace(0,1,300)*2*pi;

x=linspace(0,1,10000);

% phi=pi/2;
phi=0;

V_s=@(phi) 1/sqrt(3)*(1+2*exp(i*phi).*cos(2*pi*x));

dx=x(2)-x(1);
eta_u=zeros(size(phase));

%calculate the integral numerically
for ind=1:length(phase)
    eta_u(ind)=(sum(abs(V_s(phase(ind))))*dx).^2;
end

figure
plot(phase/(2*pi), eta_u)
axis([0,1,0,1]);
xlabel('$$\varphi / 2 \pi$$', 'interpreter', 'latex')
ylabel('$$\eta_u$$', 'interpreter', 'latex')


figure
hold on
plot(x,abs(V_s(phi)),'k')
plot(x,angle(V_s(phi))/ pi ,'r')
xlabel('x')
ylabel('V_s(x)')
legend('|V_s(x)|', 'arg[V_s(x)] / \pi')
title(['\phi = ', num2str(phi/pi), ' \pi'])
