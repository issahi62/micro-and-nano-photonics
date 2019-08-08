clear
%close all


set (0, 'defaultaxesfontsize', 12)
set (0, 'defaulttextfontsize', 12) 
set (0, 'defaultlinelinewidth', 2)


lam=1; %wavelength
% Deltas=110;  %array separation
Deltas=90;  %array separation
Mx=5;    %number of emitters in x direction
My=5;    %number of emitters in y direction
v0=1;   %peak amplitude
w=10;   %width of a single emitter

Nx=1000; % number of pixels in x direction
Ny=1000; % number of pixels in y direction

x=linspace(-600,600,Nx);
y=linspace(-600,600,Ny);
[X,Y]=meshgrid(x,y);
kx=linspace(-0.4,0.4,Nx);
ky=linspace(-0.4,0.4,Ny);
sintx=kx*lam/(2*pi);
sinty=ky*lam/(2*pi);
[KX,KY]=meshgrid(kx,ky);

V=zeros(size(X));

for m=-Mx/2+1:Mx/2;
    for n=-My/2+1:My/2;
        xm=(m-1/2)*Deltas;
        yn=(n-1/2)*Deltas;
        v=v0*exp(-((X-xm).^2+(Y-yn).^2)/w^2);
        V=V+v;
    end
end

a=v0*w^2/(4*pi)*exp(-1/4*w^2*(KX.^2+KY.^2));
A=a.*(sin(KX*Deltas*Mx/2).*sin(KY*Deltas*My/2))./(sin(KX*Deltas/2).*sin(KY*Deltas/2));


figure
subplot(2,2,1)
imagesc(x,y,abs(V).^2);
axis equal tight xy
xlabel('x/\lambda')
ylabel('y/\lambda')
title('|V(x,y)|^2')
colorbar

 subplot(2,2,2)
 imagesc(sintx,sintx,abs(A));
 axis equal tight xy
 xlabel('sin \theta_x')
 ylabel('sin \theta_y')
 title('|A(sin \theta_x, sin \theta_y)|')
 colorbar
%subplot(2,2,2)
%imagesc(sintx,sintx,abs(A).^2);
%axis equal tight xy
%xlabel('sin \theta_x')
%ylabel('sin \theta_y')
%title('|A(sin \theta_x, sin \theta_y)|^2')
%colorbar


subplot(2,2,3:4)
hold on
plot(sintx,abs(A(round(Nx/2),:))/max(abs(A(:))),'r')
plot(sintx,abs(a(round(Nx/2),:))/max(abs(a(:))),'k')
xlabel('sin \theta_x')
legend('|A(sin \theta_x, 0)|', '|a(sin \theta_x, 0)|')

ylabel('|A(x, 0)|')
