function P = simulation(drive,sol,T,eig_data,spins,ground)
% Simulates the annealing of an adiabatic quantum computation
% using a linear time schedule. Simulates fiven a list of s values
% to determine each step. (I think the idea would be to use the
% slist generated by the function that finds the spectral gap)

superpos = .5^(spins/2);
state = ones([2^spins,1])*superpos;
% norms = [];
% norms(1,1:5) = [0,1,0,0,0];

for i = 1:size(eig_data,1)
    s = eig_data(i,1);
    if s > 0
        ham = (1-s)*drive + s*sol;
        t = T*(eig_data(i,1) - eig_data(i-1,1) );

        state = expm_cheb(ham,state,t,eig_data(i,3),eig_data(i,2));

%       code for using a different matrix exponentiation function
%        ham = (-1i)*t*ham;
%        state = chbv(ham, state);

    end
end

eps = state(ground);
P = abs(eps);
end