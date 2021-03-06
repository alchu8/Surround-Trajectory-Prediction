function LL = test_mhmm_each2(data, hmm_models)
% data: single trajectory
% hmm_models: k (clusters) of hmm
    
    LL = cell(numel(hmm_models), 1);
    
    for cluster = 1:numel(hmm_models)
        if numel(hmm_models{cluster}) == 0
            continue;
        end
        LL{cluster} = mhmm_logprob(data, ...
            hmm_models{cluster}.prior, ...
            hmm_models{cluster}.transmat,...
            hmm_models{cluster}.mu,...
            hmm_models{cluster}.sigma,...
            hmm_models{cluster}.mixmat);
    end
end