function LL_all = test_hmm_all(trajectory, hmm_models)
% trajectory{type, 1}{cluster, 1}{data_num, 1}: 1-by-T observation array
% hmm_models: generate from train_hmm.m
% LL_all{type, 1}{cluster, 1}{data_num, 1} = LL from test_hmm_each.m
    LL_all = trajectory;
    for type = 1:numel(trajectory)
        for cluster = 1:numel(trajectory{type, 1})
            for data = 1:numel(trajectory{type, 1}{cluster, 1})
                LL_all{type, 1}{cluster, 1}{data, 1} = ...
                    test_hmm_each(trajectory{type, 1}{cluster, 1}{data, 1}, hmm_models);
            end
        end
    end
end