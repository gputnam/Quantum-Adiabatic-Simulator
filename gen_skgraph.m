function void = gen_skgraph(file, spins, Jf)
% Generates a graph in the sk-model given a text file (file) 
% to write to as well as the number of logical spins and the 
% ferromagnetic energy of the connections between paired spins.

f = fopen(file,'w');
mem = zeros(1,2*spins);
fprintf(f,'%i 0 0',2*spins-1);
for i = 1:spins
    fprintf(f,'\n%i %i %i', 2*i-1,2*i,-Jf);
end
for i= 1:spins
    for j = (i+1):spins
        edge = randi(2);
        if edge == 2
            edge = -1;
        end
        s1 = randi([2*i-1,2*i]);
        if mem(s1) == (spins-1)/2
            if s1 == 2*i
                s1 = 2*i-1;
            else
                s1 = 2*i;
            end
        end
        s2 = randi([2*j-1,2*j]);
        if mem(s2) == (spins-1)/2
            if s2 == 2*j
                s2 = 2*j-1;
            else
                s2 = 2*j;
            end
        end
        mem(s1) = mem(s1) + 1;
        mem(s2) = mem(s2) + 1;
        fprintf(f,'\n%i %i %i', s1,s2,edge);
    end
end
void = 0;
fclose(f);
end