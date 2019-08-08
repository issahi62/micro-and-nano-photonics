clear
% close all

w_0=150; % source width
w=400;  % target width
Delta_z=50*1e3; %distance between planes

lambda=0.633;   %wavelength

x1v=[10, 50, 100]; %example points

markers='od*v^s+';

Nx=4001; %number of datapoints

x=linspace(-1500,1500,Nx);

xlimit=500; % plotting limit of x axis

k_0=2*pi/lambda;    % wavenumber


Ix=@(xp) sqrt(2/pi)/w_0 * exp(-2*xp.^2/w_0^2);
Iu=@(up) sqrt(2/pi)/w *   exp(-2*up.^2/w^2);
u=@(xp) xp*w/w_0;



R_0=Delta_z/(w/w_0-1);
phi=k_0*x.^2/(2*R_0);



R=Delta_z/(1-w_0/w);
varphi=k_0*x.^2/(2*R);



figure
subplot(3,1,1)
hold on
plot(x,Ix(x), 'k')
plot(x,Iu(x), 'r')

for ind=1:length(x1v)
    x1=x1v(ind);
    plot(x1,Ix(x1), ['k',markers(ind)])
    plot(u(x1),Iu(u(x1)), ['r',markers(ind)])
    plot([x1, u(x1)],[Ix(x1),Iu(u(x1))], 'k--')
end

xlim([-1,1]*xlimit);

mylegend=legend('$$I(x)$$', '$$I(u)$$');
set(mylegend, 'interpreter', 'latex')
xlabel('$$x$$, $$u$$', 'interpreter', 'latex')
ylabel('$$I(x)$$, $$I(u)$$', 'interpreter', 'latex')

subplot(3,1,2)
hold on
plot(x,phi, 'k')
plot(x,varphi, 'r')
mylegend=legend('$$\phi(x)$$', '$$\varphi(u)$$');
set(mylegend, 'interpreter', 'latex')
title('unwrapped $$\phi(x)$$ and $$\varphi(u)$$', 'interpreter', 'latex')
xlabel('$$x$$, $$u$$', 'interpreter', 'latex')
ylabel('$$\phi(x)$$, $$\varphi(u)$$', 'interpreter', 'latex')

subplot(3,1,3)
hold on
plot(x,angle(exp(1i*phi)), 'k')
plot(x,angle(exp(1i*varphi)), 'r')
mylegend=legend('$$\phi(x)$$', '$$\varphi(u)$$');
set(mylegend, 'interpreter', 'latex')
title('wrapped $$\phi(x)$$ and $$\varphi(u)$$', 'interpreter', 'latex')
xlabel('$$x$$, $$u$$', 'interpreter', 'latex')
ylabel('$$\phi(x)$$, $$\varphi(u)$$', 'interpreter', 'latex')

% next calculate target using custom Angular spectrum function
Vu_rigorous=angular_spectrum_method_1D(sqrt(Ix(x)).*exp(1i*phi), x, lambda, Delta_z);
Iu_rigorous=abs(Vu_rigorous).^2;
varphi_rig=unwrap(angle(Vu_rigorous));
varphi_rig=varphi_rig-varphi_rig(round(Nx/2));

figure
subplot(2,1,1)
hold on
plot(x,Iu(x), 'r')
plot(x,Iu_rigorous, 'g--')
title('approximated target vs. rigorously calculated', 'interpreter', 'latex')
xlabel('$$u$$', 'interpreter', 'latex')
ylabel('$$I(x)$$, $$I(u)$$', 'interpreter', 'latex')
mylegend=legend('appriximated target',  'rigorous target' );
set(mylegend, 'interpreter', 'latex')

subplot(2,1,2)
hold on
plot(x,phi, 'k')
plot(x,varphi, 'r')
plot(x,varphi_rig, 'g--')
mylegend=legend('$$\phi(x)$$', '$$\varphi(u)$$',  'rigorous $$\varphi(u)$$' );
set(mylegend, 'interpreter', 'latex')
xlabel('$$x$$, $$u$$', 'interpreter', 'latex')
ylabel('$$\phi(x)$$, $$\varphi(u)$$', 'interpreter', 'latex')






