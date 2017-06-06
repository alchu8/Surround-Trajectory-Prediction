function LL = get_avg_LL(data, hmm_models)
    LL = zeros(size(hmm_models, 1), 1);
    LL_all = test_hmm_each(data, hmm_models);
    for type = 1:size(LL_all, 1)
        sum = 0;
        count = 0;
        for cluster = 1:size(LL_all{type, 1}, 1)
            if LL_all{type, 1}{cluster, 1} > -Inf
                sum = sum + LL_all{type, 1}{cluster, 1};
                count = count + 1;
            end
        end
        if count == 0
            LL(type) = -Inf;
        else
            LL(type) = (sum/count);
        end
    end
end