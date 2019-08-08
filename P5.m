
kx=linspace(-20,20,1000);
x=linspace(-10,10,10000);

d=1;
% w0=0.7;

V0=sqrt(3);
w0v=(linspace(0,2,100)).^2;

figure
for ind=1:length(w0v)

    w0=w0v(ind);

    R=w0/d;

    kp=w0*kx;

    a=1.43;


    t=exp(1i*a*cos(2*pi*x/d));

    V=V0*exp(-x.^2/w0^2);


    A=zeros(size(kp));
    M=6;
    for m=-M:M
        A=A+besselj(m,a).*exp(-1/4*(kp-2*pi*m*R).^2);
    end


    clf('reset')
    subplot(2,1,1)
    hold on
    plot(x, abs(V).^2,'b')
    plot(x, angle(t),'r')
    plot(x, abs(t),'k')
    xlabel('x')
    ylabel('|V(x,0)|^2, arg[t(x,0)]')
    legend('|V(x)|^2', 'arg[t(x)]', '|t(x)|')
    title(['w_0 = ',num2str(w0)])
%     drawnow


    subplot(2,1,2)
    plot(kx, abs(A).^2)
    xlabel('k_x')
    ylabel('|A(k_x,0)|^2')
%remember this command for animation.
    drawnow
end    

% 
% figure
% plot(w0v)