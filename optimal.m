function opt_path = optimal(data,eps)
% Takes in data on the gap values at each s and returns the optimal
% annealing schedule using the differential equation from the Roland
% paper ds/dt = eps * gap^2

% data formed as [s, gap]

l = length(data);
opt_path = zeros(l,2);
opt_path(1,1:2) = [0,0];
% use vectorization
for i = 2:l
    delta_s = data(i,1) - data(i-1,1);
    dsdt = eps*data(i,2)^2;
    delta_t = delta_s/dsdt;
    opt_path(i,1:2) = [data(i,1) , opt_path(i-1,2) + delta_t ];
end
end
