function Uvector = expm_cheb(H,vector,t,Emax,Emin)
% takes in a sparse matrix H and a state vector, returns the value of
% exp(-i*t*H/h).vector == U.vector (with h=planck's constant=1, t
% the change in time for the calculation)

% based on the article which Gian sent me:
% http://link.aps.org/doi/10.1103/PhysRevE.67.056702

% the numerical error
eps = 2^(-50);

% defining E0 (from the article--since we have the exact eigenvalues
% we don't have to approximate)
E0 = Emax - Emin;

G = 2*H/E0;
tau = E0*t/2;

tk = vector;
% not sure if this converts matrix to dense?
tk1 = G*vector;

% constants (they are reversed in the article, but that is a 
% mistake):
a0 = 1;
ak = 2;

% the action of the unitary opertor U = exp(-i*t*H/h) on vector
Uvector = a0*besselj(0,tau)*tk + ak*(-1i)*besselj(1,tau)*tk1;

k = 2;
ckn = 1;
% if the constant is smaller than eps, we end the calculation
while abs(ckn) > eps
    tkn = 2*G*tk1 - tk;
    ckn = ak*besselj(k,tau)*(-1i)^(k);
    
    Unew = ckn*tkn;   
    Uvector = Uvector + Unew;
    k = k+1;
    tk = tk1;
    tk1 = tkn;
end
end
    
    