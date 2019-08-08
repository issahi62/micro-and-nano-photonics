%location of quasi-fermi levels at absolute zero

T = 0; %0kelvin
N_size = 500; 
f_E = linspace(0, 1, N_size);
Efc = 2; Efv =1; 
Ec = 1; Ev = 2; 

mc = 1.6e-16;
h = 6.602e-34/2*pi; 
n = (((2*mc)^3/2)*(Efc - Ec)^3/2)/(3*pi^2*h^3);
p = (((2*mc)^3/2)*(Ev - Efv)^3/2)/(3*pi^2*h^3);

