function [re,te,rea,tea]=eigml_te(n1,n3,nl,the,wl,d,zl,do,tpl);

% [re,te,rea,tea]=eigml_te(n1,n3,nl,the,wl,d,zl,do,tpl);
%
% Function calculates diffraction efficiencies re (reflected)
% and te (transmitted) for multilayer gratings in the case of 
% TE-polarisation. nl is matrix of refraction indexes in the gra-
% ting region, n1 is the refraction index on the side of incidence, 
% and n3 is refraction index on the side of transmitted beams. Other 
% parameters are: angle of incidence the (in degrees), wavelength wl (in µm), 
% grating period d (in µm), vector of layer thicknesses zl ([0 z_1 z_2 ...z_n =h]), 
% diffraction orders do=(-N:M) and matrix of transition points and layer
% numbers tpl. In tpl transition poinst are in first column and 
% corresponding layer numbers in second column. The transition points 
% _only_ inside the period are needed, and values have to be scaled  
% between 0 and 1. 
%
% Other output parameters are: complex amplitudes of diffracted orders
% in reflection (rma) and in transmission (tma).

% Code is based on the eigenmode presentation of grating diffraction.
% Equations are taken from the book "Micro-Optics, Elements, Systems,
% and Applications", Ed. Hans Peter Herzig :  Chapter 2 written by 
% Jari Turunen.
%
% Markku Kuittinen, October 1994, updated February 1995
%
% last modified 16.11. 1998 (alpha_m)
%
% Filling of Fourier-coefficients into toeplitz matrix corrected 29.3.2000
%
% Boundary equations are solved by using S-matrix method presented in 
% L. Li,  J. Opt. Soc. Am. A 20, 655-660 (2003).
% Jani Tervo, July 2004