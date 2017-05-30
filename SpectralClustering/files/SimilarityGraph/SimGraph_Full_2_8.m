function W = SimGraph_Full_2_8(M, sigma)
% SIMGRAPH_FULL Returns full similarity graph
%   Returns adjacency matrix for a full similarity graph where
%   a Gaussian similarity function with parameter sigma is
%   applied.
%
%   'M' - A d-by-n matrix containing n d-dimensional data points
%   'sigma' - Parameter for Gaussian similarity function
%
%   Author: Ingo Buerk
%   Year  : 2011/2012
%   Bachelor Thesis

load 'trajectory_type.mat';

% Compute distance matrix
W_van = simGaussian(squareform(mypDist(trajectory_type{2,1})), 0.5);
W_trk = simGaussian(squareform(mypDist(trajectory_type{3,1})), 0.5);
W_ped = simGaussian(squareform(mypDist(trajectory_type{4,1})), 0.5);
W_psn = simGaussian(squareform(mypDist(trajectory_type{5,1})), 0.5);
W_cyc = simGaussian(squareform(mypDist(trajectory_type{6,1})), 0.5);
W_trm = simGaussian(squareform(mypDist(trajectory_type{7,1})), 0.5);
W_mix = simGaussian(squareform(mypDist(trajectory_type{8,1})), 0.5);

% Apply Gaussian similarity function
%W = simGaussian(W, 0.5);

save('W_van.mat', 'W_van');
save('W_trk.mat', 'W_trk');
save('W_ped.mat', 'W_ped');
save('W_psn.mat', 'W_psn');
save('W_cyc.mat', 'W_cyc');
save('W_trm.mat', 'W_trm');
save('W_mix.mat', 'W_mix');


end