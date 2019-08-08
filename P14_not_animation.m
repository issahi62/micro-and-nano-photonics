clear
%close all

set (0, 'defaultaxesfontsize', 16)
set (0, 'defaulttextfontsize', 16) 
set (0, 'defaultlinelinewidth', 2)

x=linspace(0,2,1000);
d=1;
phi=0.1*pi;
M=7;


figure

%for M=1:30 
    I=zeros(size(x));
    I=zeros(size(x));
for m=1:2:M
    I=I+1/m*sin(2*pi*m*x/d);
end
    I=I.^2*sin(phi/2)^2*(4/pi)^2;

plot(x,I) 
title(['\phi=',num2str(phi/pi),'\pi,  M=',num2str(M)])
xlabel('x')
ylabel('I(x)')
axis([min(x),max(x),0,1.4])
drawnow

pause(0.5)
%end
    