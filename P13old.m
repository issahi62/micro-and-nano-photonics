clear

lam=1; %wavelength
Deltas=110;  %array separation
M=4;    %number of emitters
v0=1;   %peack amplitude
w=30;   %width of a single emitter



Nx=500; % number of pixels

x=linspace(-300,300,Nx);
y=linspace(-300,300,Nx);
[X,Y]=meshgrid(x,y);
kx=linspace(-0.5,0.5,Nx);
ky=linspace(-0.5,0.5,Nx);
sintx=kx*lam/(2*pi);
sinty=ky*lam/(2*pi);
[KX,KY]=meshgrid(kx,ky);

V=zeros(size(X));

for m=-M/2+1:M/2;
    for n=-M/2+1:M/2;
        xm=(m-1/2)*Deltas;
        yn=(n-1/2)*Deltas;
        v=v0*exp(-((X-xm).^2+(Y-yn).^2)/w^2);
        V=V+v;
    end
end

a=v0*w^2/(4*pi)*exp(-1/4*w^2*(KX.^2+KY.^2));
A=a.*(sin(KX*Deltas*M/2).*sin(KY*Deltas*M/2))./(sin(KX*Deltas/2).*sin(KY*Deltas/2));


P13fig=figure;
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

subplot(2,2,3:4)
hold on
plot(sintx,abs(A(round(Nx/2),:))/max(abs(A(:))),'r')
plot(sintx,abs(a(round(Nx/2),:))/max(abs(a(:))),'k')
xlabel('sin \theta_x')
legend('|A(sin \theta_x, 0)|', '|a(sin \theta_x, 0)|')
ylabel('|A(x, 0)|')

title(['\lambda=',num2str(lam),', \Deltas=',num2str(Deltas), ', M=',num2str(M), ', v_0=',num2str(v0), ', w=',num2str(w)])
set(P13fig,'position',[517   198   903   690]);