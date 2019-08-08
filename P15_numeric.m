clear

x=linspace(-20,20,3000);

phi=pi/2;

kx_max=20;
D=1;
lambda=1;


V=ones(size(x));
V(abs(x)>D/2)=0;

k0=2*pi/lambda;
M=length(x);
deltax=x(2)-x(1);
kx1 = mod( 1/2 + (0:(M-1))/M , 1 ) - 1/2;
kx = kx1*(2*pi/deltax);
kx=fftshift(kx);
deltakx=kx(2)-kx(1);
if(~isrow(x))
    kx=kx(:);
end
A=fftshift(fft(ifftshift(V)))*deltax / (2*pi);
A_cut=A;
A_cut(abs(kx)>kx_max)=0;

V_out = fftshift(ifft(ifftshift(A_cut)))*M*deltakx;

figure
subplot(3,1,1)
plot(x,abs(V))
xlabel('x')
ylabel('|V(x)|')
title(['D=',num2str(D),', K=',num2str(kx_max),', \lambda=',num2str(lambda)])
subplot(3,1,2)
hold on
plot(kx,abs(A))
plot(kx,abs(A_cut))
xlabel('k_x ')
ylabel('|A(k_x)|')

subplot(3,1,3)
plot(x,abs(V_out).^2)
xlabel('x')
ylabel('|V(x)|')

