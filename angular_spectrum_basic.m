function Vout=angular_spectrum_basic(Vin,x,lambda,z)

k0=2*pi/lambda;
M=length(x);  
deltax=x(2)-x(1); 
kx=[fliplr([-1/M:-1/M:-0.5]), 0:1/M:(0.5)] * (2*pi/deltax);
kx=kx(1:M);
deltakx=1/M*2*pi/deltax; 
A=fftshift(fft(Vin))*deltax / (2*pi);
kz=sqrt(k0^2-kx.^2);
Vout=ifft( A.*exp(1i*kz*z ) )*M*deltakx;
