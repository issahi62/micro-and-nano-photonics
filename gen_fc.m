function [epfn,epfp]=gen_fc(tp,n,nfc);

% [epfn,epfp]=gen_fc(tp,n,nfc);
%
% Function solves the fourier coefficients for binary structures.
% Output vectors epfn and epfp include fourier coefficients for
% negative and positive angles, respectively. Transition points 
% are given in the vector tp, _only_ points inside the period are 
% needed, and scaling has to be between 0 and 1. n is vector of 
% refraction indexes in the grating region and nfc is the number 
% of coefficients.

% Markku Kuittinen, October 1994.
%
% Modified to handle more than two refraction indexes in January 1996