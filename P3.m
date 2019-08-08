close all
clear

wc=1;
x=linspace(-2.5,2.5,500);
% mv=[0,2,4,7];
mv=[0,1,2,5]; %how many modes plotted in 2D figure



set (0, 'defaultaxesfontname', 'Helvetica')
set (0, 'defaultaxesfontsize', 14)
set (0, 'defaulttextfontname', 'Helvetica')
set (0, 'defaulttextfontsize', 14) 


colors='krgbcmykrgbcmykrgbcmykrgbcmykrgbcmy';

HermiteGaussian=@(xv,m) (2/pi)^(1/4)*(2^m* factorial(m)*wc)^(-1/2)*hermiteH(m,sqrt(2)*xv/wc).*exp(-xv.^2/wc^2);
cm=@(m) 1;
% cm=@(m) (1/2)^m;

figure


for ind=1:5
    S=zeros(size(x));
    W=zeros(size(x));
    for m=0:ind-1
%         mode=(2/pi)^(1/4)*(2^m* factorial(m)*wc)^(-1/2)*hermite(m,sqrt(2)*x/wc).*exp(-x.^2/wc^2);
        mode=HermiteGaussian(x,m);
        S=S+cm(m)*abs(mode).^2;
        W = W + cm(m) * conj(mode).*fliplr(mode);
    end
    
    legends{ind}=['m=',num2str(ind-1)];
    legends2{ind}=['M=',num2str(ind)];
    
    mu=W./(S);
    
    subplot(2,2,1)
    hold on
    plot(x, mode, colors(ind))

    
    subplot(2,2,2)
    hold on
    plot(x, S, colors(ind))
    
    subplot(2,2,3)
    hold on
    plot(x, mu, colors(ind))
   
    subplot(2,2,4)
    hold on
    plot(x, abs(mu), colors(ind))
end

subplot(2,2,1)
plot([min(x),max(x)],[0,0],'k--')
xlabel('x')
ylabel('\psi(x)')
title('individual modes')
legend(legends)
xlim([min(x),max(x)])

subplot(2,2,2)
xlabel('x')
ylabel('S(x)')
title('spatial intensity (sum of the modes)')
legend(legends2)
xlim([min(x),max(x)])

subplot(2,2,3)
plot([min(x),max(x)],[0,0],'k--')
xlabel('x')
ylabel('\mu(x,-x)')
title('(complex) degree of coherence')
ylim([-1,1])
xlim([min(x),max(x)])
legend(legends2)

subplot(2,2,4)
xlabel('x')
ylabel('|\mu(x,-x)|')
title('modulus of degree of coherence')
ylim([0,1])
xlim([min(x),max(x)])
legend(legends2)



figure
for ind=1:length(mv)
    W=zeros(length(x),length(x));
    for m=0:mv(ind)
%         mode=(2/pi)^(1/4)*(2^m* factorial(m)*wc)^(-1/2)*hermite(m,sqrt(2)*x/wc).*exp(-x.^2/wc^2);
        mode=HermiteGaussian(x,m);
        W = W + cm(m) * mode'.* mode;
    end
    MU=W./S;
%     hold on
%     plot(x, S, colors(ind))
    subplot(length(mv),2,(ind-1)*2+1);
    imagesc(x,x,W)
    axis equal; axis tight;  axis xy;
    colorbar; caxis([-2,2]);
    colormap fireice
    title(['W(x_1,x_2), M=', num2str(mv(ind)+1)])
    xlabel('x_1')
    ylabel('x_2')
    
    subplot(length(mv),2,(ind-1)*2+2);
    imagesc(x,x,MU)
    axis equal; axis tight;  axis xy;
    colorbar; caxis([-1,1]);
    title(['\mu(x_1,x_2), M=', num2str(mv(ind)+1)])
    colormap(fireice)
    xlabel('x_1')
    ylabel('x_2')
    
    
end
