function [plotx,ploty] = plot_data(master_data)
[r,c,h] = size(master_data);
plotx = zeros([1,c]);
ploty = zeros([1,c]);
for i = 1:c
    plotx(i) = master_data(1,i,1);
    ploty(i) = master_data(1,i,2);
end
end