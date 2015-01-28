function driver = makedriver(spins)
% Generates the regular driving hamiltonian of the physical
% embedding of some number of logical bits

iarray = zeros([spins*2^spins,1]);
jarray = zeros([spins*2^spins,1]);
val = -1;
for i = 0:(2^spins -1)
    % index over all possible bit assignments bitsi
    bitsi = dec2bin(i);
    bitsi = strcat(repmat('0',1,spins-length(bitsi)), dec2bin(i));
    % find all bit assignments bitsj with hamming_distance(bitsi,
    % bitsj) = 1.
    for j = 1:spins
        bitsj = bitsi;
        if bitsj(j) == '0'
            bitsj(j) = '1';
        else
            bitsj(j) = '0';
        end
        dec = bin2dec(bitsj);
        iarray(i*spins+j,1) = i+1;        
        jarray(i*spins+j,1) = dec +1;  
    end
end
% initialize sparse matrix
driver = sparse(iarray,jarray,val);
end