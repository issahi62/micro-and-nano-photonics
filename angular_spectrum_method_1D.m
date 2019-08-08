function f_out=angular_spectrum_method_1D(f_in,x,lam,z,clipping)

% Reference:
% Band-limited angular spectrum method for numerical simulation of free-space propagation in far and near fields
% Kyoji Matsushima and Tomoyoshi Shimobaba
% Optics Express, Vol. 17, Issue 22, pp. 19662-19673 (2009)

if(nargin==4)
    clipping=1;
end

Mx=length(f_in);
dx=x(2)-x(1);

% Fourier coordinates
du = 1./(Mx*dx); 
u = [-Mx/2:Mx/2-1]*du;
u=fftshift(u);
   
W=sqrt(lam^(-2)-u.^2);
W=real(W);
        
%angular spectrum 
G=fft(f_in); 
%transfer function
H=exp(i*2*pi*W*z);
    
if(clipping==1)
    %limit frequesies
    ulimit=1./(sqrt((2*du*z)^2+1)*lam);
    %coorginates for clipping
    H(abs(u)>ulimit)=0;
end
    
%inverse FFT for propagated field
f_out=ifft (G.*H );  
