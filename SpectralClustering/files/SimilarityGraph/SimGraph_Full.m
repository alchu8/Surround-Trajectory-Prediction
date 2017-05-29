function W = SimGraph_Full(M, sigma)
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
W = squareform(mypDist(trajectory_type{1,1}));

% Apply Gaussian similarity function
W = simGaussian(W, 1);

save('W.mat', 'W');

end