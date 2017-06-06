function result = test_by_avgtype(traj, LL_index, hmm_models)
    result = traj;
    for type = 1:size(traj, 1)
        for cluster = 1:size(traj{type, 1}, 1)
            for data = 1:size(traj{type, 1}{cluster, 1}, 1)
                if LL_index{type, 1}{cluster, 1}{data, 1} == 0
                    result{type, 1}{cluster, 1}{data, 1} = ...
                        get_max_cluster(test_hmm_each(...
                        traj{type, 1}{cluster, 1}{data, 1}, hmm_models));
                else
                    result{type, 1}{cluster, 1}{data, 1} = ...
                        get_max_cluster(test_type_each(...
                        traj{type, 1}{cluster, 1}{data, 1}, ...
                        hmm_models{LL_index{type, 1}{cluster, 1}{data, 1}, 1}), true);
                    result{type, 1}{cluster, 1}{data, 1}.type = LL_index{type, 1}{cluster, 1}{data, 1};
                end
            end
        end
    end
end