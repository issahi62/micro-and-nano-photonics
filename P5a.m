x=linspace(-20,20,10000);

a=5;
d=5;

t=exp(1i*a*cos(2*pi*x/d));

figure
subplot(3,1,1)
%changed to real instead of abs
plot(x, real(t))
xlabel('x')
ylabel('|t(x)|')
title('amplitude')
subplot(3,1,2)
plot(x, angle(t))
xlabel('x')
ylabel('arg[t(x)]')
title('phase')
subplot(3,1,3)
plot(x, unwrap(angle(t)))
xlabel('x')
ylabel('arg[t(x)]')
title('phase')


J0=besselj(0,x);
J1=besselj(1,x);
figure
hold on
plot(x,J0,'b');
plot(x,J1,'r');
text22 = ['J_0(x)';'J_1(x)'];
legend(text22)



