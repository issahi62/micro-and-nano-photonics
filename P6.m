% Micro and Nanophotonics demo problem 6
% Henri Partanen 2017-2018

% wavelength, n, kappa
data = [633, 1.44947, 7.5387;
        193, 0.11174, 2.1684;
        100, 0.03604, 0.6961;
        75,  0.43718, 0.0378;
        50,  0.81067, 0.0161;
        25,  0.96959, 0.0058];

plotted_lambdas=1:6; % which rows of data will be plotted   
    
f=1/2; % fill factor
t=linspace(0,400,100); % groove depths
% t=linspace(0,900,200);
max_t_per_lambda=1.5; % max 
max_t=400;
max_eta=0.4;



use_FMM=0; %FMM only works on Matlab on UEF computers, for home use set 0,

%data vector from data array
lambda_v=data(:,1);
n_v=data(:,2);
kappa_v=data(:,3);

d_v=lambda_v*4; % grating period 

% d_v=lambda_v/2;

figure % open figure window
colors='krbcgm'; % colors of lines

my_legend={}; % cell array for line explanation texts

% loop over wavelength 
for ind=plotted_lambdas
    ind;
    lambda=lambda_v(ind);
    n=n_v(ind);
    kappa=kappa_v(ind);
    
    % eq. from problem
    eta_m1=1/pi^2.*(1+exp(-4*pi*kappa*t/lambda) - 2*cos(2.*pi.*(n-1).*t./lambda).*...
            exp(-2*pi*kappa.*t./lambda));
    
        
    subplot(2,1,1)
    hold on
    plot(t/lambda,eta_m1,[colors(ind),'--'],'linewidth',2);
%     axis([0,max_t_per_lambda,0,max_eta])
    xlim([0,max_t_per_lambda])
    xlabel('t/\lambda_0')
    ylabel('\eta_{-1}')
    
    subplot(2,1,2)
    hold on
    plot(t,eta_m1,[colors(ind),'--'],'linewidth',2);
    xlim([0,max_t])
    xlabel('t [nm]')
    ylabel('\eta_{-1}')     
        
    my_legend{end+1}=['\lambda_0 = ',num2str(lambda),' nm'];    % line expnation text
    
    % are we also calculatin with FMM?
    if(use_FMM==1)
        d=d_v(ind);
        n_out = 1; 
        
        theta = 0; %input angle
        dos = [-40:40]; %diffraction orders in FMM calculation
        tpl = [f 1]; %material edges
        diff_ord = (length(dos)-1)/2+0;   % select -1 diffraction order
        
        
        eta_m1_TE=zeros(size(t));
        eta_m1_TM=zeros(size(t));
        for ind_t = 1:length(t)
            zl = [0 t(ind_t)];
            n_in = n+1i*kappa;
            n_grating = [n+i*kappa 1]; %

            [re_TE,te_TE]=eigml_te(n_in,n_out,n_grating,theta,lambda,d,zl,dos,tpl); %FMM code for TE polarization
%             re_TE = reflection efficiency, te_TE = transmission
%             efficiency, vectors containing all diffration orders
            [re_TM,te_TM]=eigml_tm(n_in,n_out,n_grating,theta,lambda,d,zl,dos,tpl); %FMM code for TM polarization
            eta_m1_TE(ind_t)=te_TE(diff_ord); % pick -1 diffraction order
            eta_m1_TM(ind_t)=te_TM(diff_ord); % pick -1 diffraction order
%             trans(ind_t) =0.5*(te_te(diff_ord)+te_tm(diff_ord));
        end
        
        my_legend{end+1}=['\lambda_0 = ',num2str(lambda),' nm, FMM TE'];
        my_legend{end+1}=['\lambda_0 = ',num2str(lambda),' nm, FMM TM'];
        
        subplot(2,1,1)
        plot(t/lambda,eta_m1_TE,[colors(ind),'-'],'linewidth',0.5);
        plot(t/lambda,eta_m1_TM,[colors(ind),'-.'],'linewidth',0.5);
        subplot(2,1,2)
        plot(t,eta_m1_TE,[colors(ind),'-'],'linewidth',0.5);
        plot(t,eta_m1_TM,[colors(ind),'-.'],'linewidth',0.5);
        
    end
end
subplot(2,1,1)
legend(my_legend,'Location','northeastoutside') % add line explanation box

% subplot(2,1,2)
% legend(my_legend,'Location','northeastoutside')
