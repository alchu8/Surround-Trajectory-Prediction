function LL = test_hmm_each(data, hmm_models)
% data: single trajectory
% hmm_models: generate from train_hmm.m
% LL{type, 1}{cluster, 1}: Log-Likelyhood of data tested by hmm_models{type, 1}{cluster, 1}
    LL = hmm_models;
    for type = 1:size(hmm_models, 1)
        for cluster = 1:size(hmm_models{type, 1}, 1)
            LL{type, 1}{cluster, 1} = dhmm_logprob(data, ...
                hmm_models{type, 1}{cluster, 1}.prior, ...
                hmm_models{type, 1}{cluster, 1}.transmat,...
                hmm_models{type, 1}{cluster, 1}.obsmat);
        end
    end
end