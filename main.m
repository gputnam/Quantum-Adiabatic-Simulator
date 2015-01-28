function [P,eig_data_master,opt_path_master,graph,solutions] = main(file,logical, Tlist,Jflist)
% The main function for the Quantum simulation. Generates a graph and
% simulates the static and dynamics of the annealing at specified T and 
% Jf values. 
opt_eps = 1;
Teps = 0;
gap_eps = 10^(-10);
opt_path_master = [];
eig_data_master = [];
solutions = [];


P = zeros([length(Jflist),length(Tlist)]);
% simulates at each Jf value
for i = 1:length(Jflist)
    if i == 0
        while true
            gen_skgraph(file,logical,Jflist(i));
            [sol,grounds,graph] = make_sksol(file);
            if length(grounds) == 1      
                break
            end
        end
    else
        replace_skgraph(file,logical,Jflist(i));
        [sol,grounds,graph] = make_sksol(file);
    end
    
    solutions(i,1:length(grounds)) = grounds;
    ground = grounds(1);
    
    driver = makedriver(2*logical-1);
    eig_data = annealing_data(driver, sol,Teps,gap_eps);
    len = size(eig_data,1);
    
    % storing the statics values
    opt_data = eig_data(1:len,1:2);
    opt_path = optimal( opt_data, opt_eps);
    
    eig_data_master(i,1:len,1:5) = eig_data;
    opt_path_master(i,1:len,1:2) = opt_path;
    

    sim_data = eig_data(1:len, 1:2:5);
    % simulates the dynamics at each T value
    for j = 1:length(Tlist)
        T = Tlist(j);
        if i == 1 && j == 3
            P(i,j) = simulation(driver,sol,T,sim_data,2*logical-1,ground);
        else
            P(i,j) = simulation(driver,sol,T,sim_data,2*logical-1,ground);
        end
    end
end
end

    
