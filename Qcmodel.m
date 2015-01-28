function void = Qcmodel(times)
% Runs the Quantum adiabiatic simulation a specified number of times.
% T and Jf values used in sim are specified below. 
% Writes output to MATLAB .mat files

% specified values for running the simulation
Tlist = [1,10,50,100];
Jflist = linspace(3,0,31);
logical = 5;
file = 'test.txt';
timesfile = 'times5.m';

% testing the time it takes for each sim
time = zeros([times,1]);

for i = 1:times
    tic;
    [P,eig_data_master,opt_path_master,graph,solutions] = main(file,logical, Tlist,Jflist);
    savefile = strcat('run',num2str(i+55),'.mat');
    save(savefile,'P','eig_data_master','opt_path_master','graph','solutions','logical','Tlist','Jflist');
    time(i) = toc;
end
save(timesfile,'time');
void = 0;
end
