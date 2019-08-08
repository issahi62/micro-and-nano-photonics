clear

omega=linspace(30,70,2000);
omega_0=50;

Omega=10;
omega_F=5;


constant_Omega_or_omega_F=1; % 1 or 2


% Omega_per_omega_F_v=[2,1,0.7,0.5,0.3];
% Omega_per_omega_F_v=[6,2.5,1.5,1,0.7,0.5];
% Omega_per_omega_F_v=[6];
Omega_per_omega_F_v=[0.6, 0.8, 1.0, 1.2, 2.0];
% Omega/omega_F

Delta_t=linspace(-3,3,2000);

%N=100; % modes considered
N=20; % modes considered

colors='krgbmcy';
symbols={'-','--',':','-.','-','--',':','-.''-','--',':','-.''-','--',':','-.'};


set (0, 'defaultaxesfontname', 'Helvetica')
set (0, 'defaultaxesfontsize', 11)
set (0, 'defaulttextfontname', 'Helvetica')
set (0, 'defaulttextfontsize', 11) 


spectrumfigu=figure
coherencefigu=figure
for ind=1:length(Omega_per_omega_F_v)
    Omega_per_omega_F=Omega_per_omega_F_v(ind);
    
    if(constant_Omega_or_omega_F==1)
        Omega=Omega_per_omega_F*omega_F;
        Omega_Delta_t=Delta_t*Omega;
        
    elseif(constant_Omega_or_omega_F==2)    
        omega_F=Omega/Omega_per_omega_F;
        Omega_Delta_t=Delta_t*Omega;
    end
       
    S=zeros(size(omega));
    sum1=zeros(size(omega));
    sum2=zeros(size(omega));

    for n=-N:N;


        envelope=exp(-2*(omega-omega_0).^2/Omega^2);
        
        omega_mode=omega_0+n*omega_F;
        
        S_mode=exp(-2*(omega_mode-omega_0).^2/Omega^2);
        
        sum1=sum1+exp(-2*n^2*omega_F^2/Omega^2).*exp(-i*n*omega_F*Delta_t);
        sum2=sum2+exp(-2*n^2*omega_F^2/Omega^2);
        
        figure(spectrumfigu);
        subplot(length(Omega_per_omega_F_v),1,ind)
        hold on
    %     plot(omega, S, [symbols{ind},colors(ind)])
    %     plot(omega, envelope, ['--',colors(ind)])
    %     plot(omega, S, colors(ind), 'linewidth',1.5)
        if(S_mode<1e-10) %Octave doesn't want plot extemely tiny values like 1e-314, so let's make them zeros
          S_mode=0;
        end
        plot([1,1]*omega_mode, [0,S_mode], [colors(ind),'+-'], 'linewidth',1.5)
        
    end    

    gamma=exp(-i*omega_0*Delta_t).*sum1./sum2;

    
    figure(spectrumfigu);
    subplot(length(Omega_per_omega_F_v),1,ind)
    hold on
%     plot(omega, S, [symbols{ind},colors(ind)])
%     plot(omega, envelope, ['--',colors(ind)])
%     plot(omega, S, colors(ind), 'linewidth',1.5)
%     plot([1,1]*omega_mode, [0,S_mode], [colors(ind),'-'], 'linewidth',1.5)
%     hold on
    plot(omega, envelope, 'k', 'linewidth',0.5)
    axis([min(omega), max(omega), 0, 1])
    xlabel('\omega')
    ylabel('S(\omega)')
    title(['\Omega / \omega _F = ', num2str(Omega_per_omega_F)])
    
    
    figure(coherencefigu);
%     axis([min(omega), max(omega), 0, 6])
    subplot(2,1,1)
    hold on
    plot(Delta_t, abs(gamma), [symbols{ind},colors(ind)], 'linewidth',1.5)
    % axis([min(Delta_t),max(Delta_t),0,1])
    xlabel('\Delta t')
    ylabel('|\gamma(\Delta t)|')
    subplot(2,1,2)
    hold on
    plot(Omega_Delta_t, abs(gamma), [symbols{ind},colors(ind)], 'linewidth',1.5)
    % axis([min(Omega_Delta_t),max(Omega_Delta_t),0,1])
    xlabel('\Omega \Delta t')
    ylabel('|\gamma(\Delta t)|')
end

% Omega_Delta_t=linspace(-20,20,500);
% 
% O_per_oF=1;
% 
% Nv=[1:4];
% 
% colors='krgbcmy';
% Omega=1;
% 
% figure
% hold on
% 
% for ind_N=1:length(Nv)
%     N=Nv(ind_N);
%     
%     
%     sum1=zeros(size(Omega_Delta_t));
%     sum2=zeros(size(Omega_Delta_t));
%     for n=-N:N;
%         sum1=sum1+exp(-2*n^2*O_per_oF^2).*exp(-i*n*Omega_Delta_t/O_per_oF);
%         sum2=sum2+exp(-2*n^2*O_per_oF^2);
%     end    
%     gamma=exp()
% end