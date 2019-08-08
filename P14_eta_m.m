clear

phi_v=linspace(0,4,200)*pi;
mv=[0:7];
%mv(1)=0.00001;

mylegend={};

figure
hold on
for indm=1:length(mv)
  m=mv(indm);
  if(m==0)
    T_m=0.5*(1+exp(1i*phi_v));
  else
    T_m=1/(1i*2*pi*m).*(1-(-1)^m).*(1-exp(1i*phi_v));
  end
  eta_m=abs(T_m).^2;
  plot(phi_v/pi, eta_m);
  mylegend{indm}=['m=',num2str(m)];
end
legend(mylegend)
xlabel('\phi / \pi')
ylabel('\eta_m')