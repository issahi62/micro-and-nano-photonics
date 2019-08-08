function f_out=angular_spectrum_method(f_in,x,y,lam,z,clipping)

% Function to propagate field from source plane to arbitrary plane.
% Uses traditional angular spectrum method or band-limiting variant to 
% reduce numerical errors caused by sampling.

% output:
% f_out = propagated field

% input:
% f_in = field at source plane
% x and y = spatial coordinate vectors
% lam = wavelength
% z = propagation distance
% clipping = 1 for Band-limited angular spectrum method, else traditional,
%            default 1.

% Reference:
% Band-limited angular spectrum method for numerical simulation of free-space propagation in far and near fields
% Kyoji Matsushima and Tomoyoshi Shimobaba
% Optics Express, Vol. 17, Issue 22, pp. 19662-19673 (2009)

if(nargin==5)
    clipping=1;    
end

[My,Mx] = size(f_in); 

dx=x(2)-x(1);
dy=y(2)-y(1);

% Fourier coordinates
du = 1./(Mx*dx); 
u = [-Mx/2:Mx/2-1]*du;
u=fftshift(u);
dv = 1./(My*dy); 
v = [-My/2:My/2-1]*dv;
v=fftshift(v);
        
% Fourier coordinates matrixes
[U,V]=meshgrid(u,v);
W=sqrt(lam^(-2)-U.^2-V.^2);
W=real(W);
        
% angular spectrum 
G=fft2(f_in); 
%transfer function
H=exp(i*2*pi*W*z);
    
% difference from traditional angular spectrum method
if(clipping==1)
    %limit frequencies
    ulimit=1./(sqrt((2*du*z)^2+1)*lam);
    vlimit=1./(sqrt((2*dv*z)^2+1)*lam);
    %coorginates for clipping
    Uellipse=U.^2/ulimit^2 + V.^2*lam^2;
    Vellipse=V.^2/vlimit^2 + U.^2*lam^2;
    %clip G and H
%     G(Uarea>1 | Varea>1)=0;
    H( Uellipse>1 | Vellipse>1 )=0;      
end
    
%inverse FFT for propagated field
f_out=ifft2 (G.*H );  

