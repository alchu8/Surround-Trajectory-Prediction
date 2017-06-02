function cell_out = Cluster2Cell(member_hard, membership_value, conf)
% according to member_hard by SpectralClustering.m, return cell object
% containing indices for each cluster
    k = unique(member_hard);
    cell_out = cell(length(k), 1);
    for i = k
        k_ele = [];
        for j = 1:numel(member_hard)
            if member_hard(j) == i && membership_value(j) >= conf
                k_ele = [k_ele, j];
            end
        end
        cell_out{i, 1} = k_ele;
    end
end