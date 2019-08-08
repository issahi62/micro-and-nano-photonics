
filename='P5animation';

kx=linspace(-20,20,1000);
x=linspace(-10,10,10000);

d=1;
% w0=0.7;

V0=sqrt(3);
w0v=(linspace(0,2,500)).^2;


figwindow=figure;
set(figwindow, 'Position', [300   300    	1280 720])

%create video object
vidObj = VideoWriter(filename,'MPEG-4');
vidObj.Quality=100;
open(vidObj);

for ind=1:length(w0v)

    w0=w0v(ind);

    R=w0/d;

    kp=w0*kx;

    a=1.43;


    t=exp(i*a*cos(2*pi*x/d));

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
    ylim([0,max(abs(A).^2)])
    drawnow
    
    set(figwindow,'nextplot','replacechildren'); %delete previous frame 
    %without this line you might run out of memory with long animations.

    currFrame = getframe(figwindow);
    writeVideo(vidObj,currFrame);
end    
close(vidObj);
% 
% figure
% plot(w0v)