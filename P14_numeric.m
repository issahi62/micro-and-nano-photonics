clear

x=[0:0.02:50];
d=3;
phi=pi/2;

kx_min=1;
kx_max=30;

V=ones(size(x));

lambda=0.633;
for ind=0:ceil(max(x)/d)
    V(x>ind*d & x<=(ind*d+d/2))=exp(1i*phi);
end

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
A_cut(abs(kx)<kx_min)=0;
A_cut(abs(kx)>kx_max)=0;

V_out = fftshift(ifft(ifftshift(A_cut)))*M*deltakx;

figure
subplot(3,1,1)
plot(x,angle(V))
xlabel('x [\mum]')
ylabel('arg[V(x)]')
ylim([-0,pi])
subplot(3,1,2)
hold on
plot(kx,abs(A))
plot(kx,abs(A_cut))
xlabel('k_x ')
ylabel('|A(k_x)|')

subplot(3,1,3)
plot(x,abs(V_out).^2)
xlabel('x [\mum]')
ylabel('|V(x)|')
ylim([-0,pi])
