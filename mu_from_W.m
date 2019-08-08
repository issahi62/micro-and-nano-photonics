function mu=mu_from_W(W)

int = diag(W);
S1 = repmat(int',length(W),1);
S2 = repmat(int,1,length(W));
mu = W./sqrt(  S1.*S2 );