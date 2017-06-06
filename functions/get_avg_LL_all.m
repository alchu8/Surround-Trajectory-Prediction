function LL_avg_all = get_avg_LL_all(traj, hmm_models)
    LL_avg_all = traj;
    for type = 1:size(traj, 1)
        for cluster = 1:size(traj{type, 1}, 1)
            for data = 1:size(traj{type, 1}{cluster, 1}, 1)
                LL_avg_all{type, 1}{cluster, 1}{data, 1} = ...
                    get_avg_LL(traj{type, 1}{cluster, 1}{data, 1}, hmm_models);
            end
        end
    end
end