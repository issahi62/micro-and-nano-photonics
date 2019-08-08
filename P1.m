clear
close all

S0=1;
V0=1;
I0=V0^2;


N_pixel=1001; %number of pixels in the plots
x=linspace(0,5,N_pixel); % x coordinate vector
omega_t=linspace(-10,10,N_pixel);
omega_Delta_t=linspace(-20,20,N_pixel);

nv=[1, 2, 5, 20]; %values of n to use
% nv=[1, 2.4, 5.7, 20.84664]; %values of n to use

set(0, 'defaultaxesfontname', 'Helvetica')
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaulttextfontname', 'Helvetica')
set(0, 'defaulttextfontsize', 15) 
set(0, 'defaultlinelinewidth', 2)


%open figure windows
intensityfigu=figure;
comparisonfigu = figure;

colors='krgbcmy'; % line colors

x_halfs=zeros(2,length(nv)); %matrix to collect spectrum FWHM values

legend_texts={};
for ind=1:length(nv)
    figure(intensityfigu);
    hold on

    n=nv(ind)
    Sx=S0*x.^(2*n).*exp(-2*n*(x-1));
    
    % first use intersections subfunction to get rough values of FWHM
    [x0,y0,iout,jout] = intersections(x,Sx,[0,max(x)],[1,1]*S0/2);

    % Calculate spectrum FWHM values
    merit_S_half=@(xp) abs(0.5-xp.^(2*n).*exp(-2*n*(xp-1)));
    x1=fminsearch(merit_S_half,x0(1));
    x2=fminsearch(merit_S_half,x0(2));
    x_halfs(:,ind)=[x1;x2];


    Vt=V0./((1+i*omega_t/n).^(n+1));
    It=I0./((1+(omega_t/n).^2).^(n+1));

    temp_phase=angle(Vt); % arg[V(t)]
    temp_phase_unwrap=unwrap(angle(Vt));
    temp_phase_unwrap=temp_phase_unwrap-temp_phase_unwrap(round(N_pixel/2));



    subplot(2,2,1)
    hold on
    plot(x,Sx,colors(ind));
    xlabel('x')
    ylabel('S(x)')
    title('spectrum')
    plot([x(1),x(end)],[1,1]*S0/2, 'k')
    plot(x0,y0,'ko')

    subplot(2,2,2)
    hold on
    plot(omega_t,It,colors(ind))
    % plot(omegat,abs(Vt).^2,['k--'])
    xlabel('\omega_0 t')
    ylabel('I(t)')
    title('temporal intensity')

    subplot(2,2,3)
    hold on
    plot(omega_t,temp_phase,colors(ind))
    xlabel('\omega_0 t')
    ylabel('\phi(t)')
    title('temporal phase')

    subplot(2,2,4)
    hold on
    plot(omega_t,temp_phase_unwrap,colors(ind))
    xlabel('\omega_0 t')
    ylabel('\phi(t)')
    title('temporal phase unwrapped')


    legend_texts{ind}=['n=',num2str(n)];

    figure(comparisonfigu);
    subplot(2,1,1)
    hold on
    plot(omega_t,It,[colors(ind),'-'])
end

figure(intensityfigu);
legend(legend_texts)

x_halfs



coherencefigu=figure;
hold on

legend_texts={};

for ind=1:length(nv)
%for ind=1:3
    figure(coherencefigu);
    
    n=nv(ind);
    Sx=S0*x.^(2*n).*exp(-2*n*(x-1));
    gamma=1./((1+i*omega_Delta_t/(2*n)).^(2+n+1));

    gamma_phase=angle(gamma);
    gamma_phase_unwrap=unwrap(angle(gamma));
    gamma_phase_unwrap=gamma_phase_unwrap-gamma_phase_unwrap(round(N_pixel/2));



    subplot(2,2,1)
    hold on
    plot(x,Sx,colors(ind));
    xlabel('x')
    ylabel('S(x)')
    title('spectrum')
    plot([x(1),x(end)],[1,1]*S0/2, 'k')


    subplot(2,2,2)
    hold on
    plot(omega_Delta_t,abs(gamma),colors(ind))
%    plot(omegat,abs(Vt).^2,['k--'])
    xlabel('\omega_0 \Delta t')
    ylabel('|\gamma(\Delta t)|')
    title('degree of temporal coherence')

    subplot(2,2,3)
    hold on
    plot(omega_Delta_t,gamma_phase,colors(ind))
    xlabel('\omega_0 \Delta t')
    ylabel('\phi(\Delta t)')
    title('coherence phase')

    subplot(2,2,4)
    hold on
    plot(omega_Delta_t,gamma_phase_unwrap,colors(ind))
    xlabel('\omega_0 \Delta t')
    ylabel('\phi(\Delta t)')
    title('coherence phase unwrapped')


    legend_texts{ind}=['n=',num2str(n)];

    figure(comparisonfigu);
    hold on
    subplot(2,1,1)
    hold on
    plot(omega_Delta_t/2,abs(gamma),[colors(ind),'--'],'linewidth',2)
    xlabel('\omega_0 t, \omega_0 \Delta t')
    ylabel('I(\omega_0 t), \gamma(\omega_0 \Delta t/2)')

end
figure(coherencefigu)
legend(legend_texts)
    subplot(2,2,1)
    hold on
    plot([x(1),x(end)],[1,1]*S0/2, 'k')

n_v=linspace(0,20,100);
ratio=2*sqrt((2.^(1./(n_v+1/2))-1)./(2.^(1./(n_v+1))-1));

figure(comparisonfigu);
subplot(2,1,2)
plot(n_v,ratio)
xlabel('n')
ylabel('\Delta T / T')

