function [prototypes_pre, cluster_id] = findk(trajectory_data, cell_out, membership_value)
% find the best k for a vehicle type; initially, k > best_k
% trajectory_data: trajectories for a vehicle type e.g. trajectory_type{1}
% cell_out: k-clustered trajectory indices organized in cells for a vehicle
% type, returned by Cluster2Cell on clusters found by SpectralClustering on
% large k
% membership_value: for each data, confidence value in [0,1]
% returns k route prototypes before merging and id of remaining clusters
% after merging
    % first, reparameterize trajectories from F = {x(t),y(t)} to {x(s),y(s)}
    % s is arc length
    L = 15; % resample to fixed length L
    trajectories = zeros(length(trajectory_data), 2*L); % parameterized by s
    for i = 1:length(trajectory_data)
        x = trajectory_data{i, 1}(1, :);
        y = trajectory_data{i, 1}(2, :);
        x_t = derivative(x);
        y_t = derivative(y);
        s = cumtrapz( sqrt(x_t.^2 + y_t.^2 ) ); % cumulutive distance tranveled along the arc
        t = 1:1:length(x);
        X = s.';
        V = [ t.', x.', y.' ];
        S = s(end); % S is total arc length
        s0 = s(1);
        Xq = linspace(s0, S, L); % L equally spaced indices between s0 and S
        Vq = interp1(X,V,Xq); % interpolate for t(s) and x(t(s)) and y(t(s))
        x_s = Vq(:,2)'; % Euclidean distances between consecutive points are equal
        y_s = Vq(:,3)';
        temp = [x_s; y_s];
        trajectories(i, :) = temp(:)'; % reparameterized traj in terms of arc length s
    end
    
    % second, find route prototypes by weighted average in each cluster
    k = length(cell_out); % number of initial clusters
    prototypes_pre = zeros(k, 2*L);
    for c = 1:k % cth cluster
        sum_weights = 0;
        for f = cell_out{c, 1} % fth vector
            u = membership_value(f) ^ 2; % weight
            sum_weights = sum_weights + u;
            prototypes_pre(c, :) = prototypes_pre(c, :) + u * trajectories(f, :);
        end
        prototypes_pre(c, :) = prototypes_pre(c, :) / sum_weights; % normalize
    end
    
    % third, merge similar prototypes to refine k
    eps = 1; % allowable radius between corresponding points along two routes
    dist_thres = L * eps; % total distance threshold
    dist_pairs = zeros(1, k*(k-1)/2); % distance between every prototype pair
    count = 1;
    for i = 1:k-1
        a = prototypes_pre(i, :);
        for j = i+1:k
            b = prototypes_pre(j, :);
            dist_pairs(count) = dtw_c(a, b, 3);
            count = 1 + count;
        end
    end
    sim_graph = squareform(dist_pairs); % adjacency matrix
    [i, j] = find(sim_graph < dist_thres);
    n = j(j > i); % consider only upper triangle since matrix is symmetric
    cluster_id = 1:k;
    for i = 1:length(n)
        try
            cluster_id(cluster_id == n(i)) = []; % merge clusters
        catch ME
            disp(ME.message);
        end
    end
end