Anumerical=fftshift(fft2(V));
figure
imagesc(abs(Anumerical))
axis equal; axis tight;