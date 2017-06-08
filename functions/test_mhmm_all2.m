function LL_all = test_mhmm_all2(trajectory, hmm_models)

    LL_all = trajectory;
    
    for cluster = 1:numel(trajectory)
        for data = 1:numel(trajectory{cluster, 1})
            LL_all{cluster, 1}{data, 1} = ...
                get_max_cluster2(test_mhmm_each2(...
                trajectory{cluster, 1}{data, 1}, hmm_models));
        end
    end
    
end