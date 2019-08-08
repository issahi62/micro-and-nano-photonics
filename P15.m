clear
% close all

%pkg load symbolic %For Octave

set (0, 'defaultaxesfontsize', 16)
set (0, 'defaulttextfontsize', 16) 
set (0, 'defaultlinelinewidth', 2)

% x=linspace(-1,1,200);
x=linspace(-2,2,500);
D=1;

KD=20;

kx=linspace(-150,150,400); 

K=KD/D;

%filename='example_video';

% %create video object
% vidObj = VideoWriter(filename,'Motion JPEG AVI');
% vidObj.Quality=100;
% vidObj.FrameRate = 10;
% open(vidObj);

A=(exp(1i*kx*D/2)-exp(-1i*kx*D/2))./(2*pi*1i.*kx);
A_max=max(abs(A(:)));

figwindow=figure;
% set(figwindow, 'Position', [300   300    	1280 720])
% for KD=1:0.5:150 
% for KD=1:4:150 
%for KD=linspace(1,150,300)
    clf(figwindow,'reset');
% for KD=10
    
%     V=1/pi*(sinint(KD*(x/D+1/2)) - sinint(KD*(x/D-1/2)));
V=1/pi*(sinint(K*(x+D/2)) - sinint(K*(x-D/2)));


    
    
    subplot(2,1,1)
    
    hold on
    plot(kx,abs(A),'b')
    plot([1,1]*-K, [0,1]*A_max, 'k')
    plot([1,1]*K, [0,1]*A_max, 'k')
    title(['KD=',num2str(KD)])
    xlabel('k_x')
    ylabel('|A(k_x)|')
    axis([min(kx),max(kx),0,A_max])
%     drawnow    
    
    subplot(2,1,2)
    plot(x/D,abs(V).^2)
    xlabel('x/D')
    ylabel('|V(x_Q, z_Q)|^2')
    
    axis([-1,1,0,1.4])
%     drawnow
%     xlim
    
%    set(figwindow,'nextplot','replacechildren'); %delete previous frame 
%    currFrame = getframe(figwindow); 
%     writeVideo(vidObj,currFrame);
%end
% close(vidObj);