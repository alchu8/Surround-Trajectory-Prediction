function result = get_clustered_traj(trajectory_type, W_all, k)
    result = cell(8, 1);
    for veh_type = 1:8
        traj_now = trajectory_type{veh_type};
        W_now = W_all{veh_type};
        [~, member_hard, ~] = SpectralClustering(W_now, k(veh_type), 3);
        cell_out = Cluster2Cell(member_hard);
        traj_cluster = cell(length(unique(member_hard)), 1);
        for cNum = 1:size(traj_cluster, 1)
            traj_temp = cell(length(cell_out{cNum}), 1);
            for n = 1:length(cell_out{cNum})
                traj_temp{n} = traj_now{cell_out{cNum, 1}(n), 1};
            end
            traj_cluster{cNum} = traj_temp; 
        end
        result{veh_type} = traj_cluster;
    end
end