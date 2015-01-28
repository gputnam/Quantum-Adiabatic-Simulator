function [e1,e2,gap,emax] = find_eigs(A)
% computes the spectral gap between the two smallest eigenvalues
% given a sparse matrix
opts.tol = 10^(-7);
eig2 = eigs(A,2,'sa',opts);
e1 = eig2(1);
e2 = eig2(2);
gap = e2 - e1;
emax = eigs(A,1,'la',opts);
end