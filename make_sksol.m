function [sol, grounds,grph] = make_sksol(file)
% Generates the solution Hamiltonian given an input file where:
% the first row is:
% a 0 0
% where a is the number of spins.
% And each successive line is a connection on the physical graph. 
% For ex:
% a b c
% where a is the first bit on the connection, b is the second, and
% c is the value of the connection

fid= fopen(file);
grph = fscanf(fid, '%f', [3 inf]);
grph = grph.';
[r,c] = size(grph);
phys = grph(1,1);
graph = grph(2:r,1:c);
r = r-1;
hC = zeros([2^phys,1]);
min = 100;
% index over all possible spin assignments
for i = 0:(2^phys -1)
    % use binary representations to index.
    bits = dec2bin(i);
    bits = strcat(repmat('0',1,phys+1-length(bits)), bits);
    % determine the energy value of the bit assignment
    val = 0;
    for j = 1:r
        if bits(graph(j,1)) == bits(graph(j,2))
            val = val + graph(j,3);
        
        elseif bits(graph(j,1)) ~= bits(graph(j,2))
            val = val - graph(j,3);
        end
    end
    if val < min
        grounds = [i+1];
        min = val;
    elseif val == min
        grounds(length(grounds)+1) = i+1;
    end
    hC(i+1) = val;
end
sol = spdiags(hC,0,2^phys,2^phys);
fclose(fid);
end


