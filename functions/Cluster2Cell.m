function cell_out = Cluster2Cell(member_hard, membership_value, conf)
% according to member_hard by SpectralClustering.m, return cell object
% containing indices of trajectory in trajectory_data for each cluster, 
% retaining only those above a membership confidence threshold.
    k = unique(member_hard); % array of all cluster id's
    cell_out = cell(length(k), 1);
    for i = 1:length(k)
        % logical indexing to find all members belonging to cluster k(i)
        members = find(member_hard == k(i));
        % find those members that have high membership confidence
        cell_out{i, 1} = members(membership_value(members) >= conf);
    end
end