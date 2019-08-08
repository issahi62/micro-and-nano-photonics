clear

D=8; % slit width

%M=41; % number of sampling points
%x=linspace(-15,15,M); % sampling point for x
x=-15*4:0.75/4:15*4;

M=length(x);
% sampling for analytical curves
kxmax=4;
xa=linspace(-1*D, 1*D, 500);
kxa=linspace(-kxmax,kxmax,500);
Va=ones(size(xa));
Va(abs(xa)>D/2)=0; %top hat function of slit
%analytical angular spectrum of slit
Aa=(exp(1i*kxa*D/2)-exp(-1i*kxa*D/2))./(2*pi*1i.*kxa); 

% numerical 
V=ones(size(x));
V(abs(x)>D/2)=0;
deltax=x(2)-x(1); 
kx=[fliplr(-1/M:-1/M:-0.5), 0:1/M:(0.5)] * (2*pi/deltax);
kx=kx(1:M); %make sure that kx has same number of elements as x
A=fftshift(fft(V))*deltax / (2*pi);
A_not_shifted=fft(V)*deltax / (2*pi);

figure
subplot(2,1,1)
hold on
plot(xa,abs(Va),'r')
plot(x,abs(V),'ko')
xlabel('x')
ylabel('|V(x)|')
legend('analytical','numerical FFT')
%xlim([min(xa),max(xa)])
ylim([-0.1, 1.1])
subplot(2,1,2)
hold on
plot(kxa,abs(Aa),'r')
plot(kx,abs(A),'ko')
%xlim([-kxmax, kxmax])
legend('analytical','numerical FFT')
xlabel('k_x')
ylabel('|A(k_x)|')
%
%figure
%subplot(3,1,1)
%plot(abs(V),'o-')
%xlabel('sampling points')
%title('V')
%axis tight
%subplot(3,1,2)
%plot(abs(fft(V)),'o-')
%xlabel('sampling points')
%title('fft(V)')
%axis tight
%subplot(3,1,3)
%plot(abs(fftshift(fft(V))),'o-')
%xlabel('sampling points')
%title('fftshift(fft(V))')
%axis tight