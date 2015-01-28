function P = simulationlin(drive,sol,T,eig_data,spins,ground)
% Simulates the annealing of an adiabatic quantum computation
% using a linear time schedule. Simulates using an equal delta-s at
% every step.

step = .1;
superpos = .5^(spins/2);
% sets planck's constant to one
state = ones([2^phys,1])*superpos;
N = round(T/step);

for i = 1:N
    s = i/N;
    ham = (1-s)*drive + s*sol;
    t = step;
    state = expm_cheb(ham,state,t,eig_data(i,3),eig_data(i,2));
end

eps = state(ground);
P = abs(eps);
end