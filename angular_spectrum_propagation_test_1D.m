clear
close all
% units are in micrometers
D=8; % slit width
lambda=0.633; % wavelength
%zv=linspace(0,1000,100); % z values
zv=800; % z values

pauseTime=0.05;

xPlotMax=100; % how large area to plot
M=4001; % number of sampling points
x=linspace(-500,500,M); % sampling point for x
V=ones(size(x)); % create top hat source field
V(abs(x)>D/2)=0;

figure
% loop over z values
for indZ=1:length(zv)
    z=zv(indZ); 
    
%     % this version of the angular spectrum is in same notation as course 
%     % but has some numerical noise
%    Vout=angular_spectrum_basic(V,x,lambda,z); 

%     % this version of the angular spectrum code causes less noise, but
%     % has slightly different notation
     Vout=angular_spectrum_method_1D(V,x,lambda,z); 
    hold off
    plot(x,abs(V).^2)
    hold on
    plot(x,abs(Vout).^2)
    title(['z=',num2str(z)])
%    xlim([-xPlotMax, xPlotMax])
    ylim([0, 1.5])
    xlabel('x [\mum]')
    ylabel('|V(x)|^2')
    drawnow
    pause(pauseTime)
end