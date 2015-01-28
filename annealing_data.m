function eigs = annealing_data(drive,sol,Teps,gap_eps)
% Computes the gap data of an annealing of a pair of

% retruns data as array of [s, gap, smallest eig, next smallest eig
% , biggest eig]

% Initializing values
smin = 0;
smax = 1;
subdiv = 100;
data = [];
gap_err = 1;
before_min = false;

% finding data for s=0, s=1
[e1,e2,gap,emax] = find_eigs(drive);
data(1,1:5) = [0,gap,e1,e2,emax];

[e1,e2,gap,emax] = find_eigs(sol);
data(2,1:5) = [1,gap,e1,e2,emax];

% Calculates data inside [smin,smax] in subdiv subdivisions
% calculates again about the found minimum gap until either
% time or gap accuracy is sufficient

i = 0;
while smax - smin > Teps && gap_err > gap_eps && before_min == false;
    delta_s = (smax-smin)/subdiv;
    before_min = true;
    s = smin;
    for j = 1:subdiv-1
        index = i*(subdiv-1)+j+2;
        s = s + delta_s;
        [e1,e2,gap,emax] = find_eigs(drive*(1-s)+sol*s);
        data(index,1:5) = [s,gap,e1,e2,emax];
        % determining if we have found the minimum
        if j >= 3 && before_min
            if data(index-2,2) > data(index-1,2) && data(index,2) > data(index-1,2)
                before_min = false;
                smax = data(index,1);
                smin = data(index-2,1);
                if i == 0
                    foundmin = data(index-1,2);
                else
                    gap_err = abs(foundmin-data(index-1,2));
                    foundmin = data(index-1,2);
                end
            end
        end
    end
    i = i+1;
end
% sorting data, deleting repeated rows
data = sortrows(data);

eigs = [];
eigs(1,1:5) = data(1,1:5);
j=2;
for i = 2:size(data,1)
    if data(i,1) ~= data(i-1,1)
        eigs(j,1:5) = data(i,1:5);
        j = j+1;
    end
end
end



