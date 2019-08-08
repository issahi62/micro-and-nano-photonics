function [N_TE,N_TM,t,Phi_TE,Phi_TM,R_TE,R_TM, R_TE_per_R_TM]=Form_birefringence(lambda, n1, n2, ni, nt, f)


k_0=2*pi/lambda;

N_TE=sqrt(n1.^2.*f + n2.^2.*(1-f));
N_TM=n1.*n2./sqrt(n2.^2.*f + n1.^2.*(1-f));

t=lambda./(4.*(N_TE-N_TM));

Phi_TE=k_0 .* N_TE .* t;
Phi_TM=k_0 .* N_TM .* t;

R_TE=abs((N_TE.*(ni-nt).*cos(Phi_TE) - i.*(ni.*nt-N_TE.^2).*sin(Phi_TE))./...
         (N_TE.*(ni+nt).*cos(Phi_TE) - i.*(ni.*nt+N_TE.^2).*sin(Phi_TE))).^2;
     
R_TM=abs((N_TM.*(ni-nt).*cos(Phi_TM) - i.*(ni.*nt-N_TM.^2).*sin(Phi_TM))./...
         (N_TM.*(ni+nt).*cos(Phi_TM) - i.*(ni.*nt+N_TM.^2).*sin(Phi_TM))).^2;   
     
R_TE_per_R_TM = R_TE ./ R_TM;     