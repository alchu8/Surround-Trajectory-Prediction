function LL = test_mhmm_each(data, hmm_models)
% data: single trajectory
% hmm_models: generate from train_hmm.m
% LL{type, 1}{cluster, 1}: Log-Likelyhood of data tested by hmm_models{type, 1}{cluster, 1}
    
    LL = hmm_models;
    for type = 1:size(hmm_models, 1)
        for cluster = 1:size(hmm_models{type, 1}, 1)
            if numel(hmm_models{type, 1}{cluster, 1}) == 0
                continue;
            end
            LL{type, 1}{cluster, 1} = mhmm_logprob(data, ...
                hmm_models{type, 1}{cluster, 1}.prior, ...
                hmm_models{type, 1}{cluster, 1}.transmat,...
                hmm_models{type, 1}{cluster, 1}.mu,...
                hmm_models{type, 1}{cluster, 1}.sigma,...
                hmm_models{type, 1}{cluster, 1}.mixmat);
        end
    end
end