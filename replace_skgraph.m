function void = replace_skgraph(file,spins, Jf)
% loads a graph from a given file and replaces the Jf values of the graph
% with the specified value

fid= fopen(file,'r');
% load graph
graph = fscanf(fid, '%f', [3 inf]);
graph = graph.';
fclose(fid);
f = fopen(file,'w');

% replace Jf, re-write onto file
for i = 1:size(graph,1)
    if i > 1 && i <= spins+1
        graph(i,3) = -Jf;
    end
    if i > 1
        fprintf(f,'\n');
    end
    fprintf(f,'%i %i %i', graph(i,1),graph(i,2),graph(i,3));
end

% close, end
fclose(f);
void = 0;
end
