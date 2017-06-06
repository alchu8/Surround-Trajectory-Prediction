function LL = test_type_each(data, hmm_model_type)
% hmm_model_type = hmm_models{type, 1}
    LL = hmm_model_type;
    for cluster = 1:size(hmm_model_type, 1)
        LL{cluster, 1} = dhmm_logprob(data, ...
            hmm_model_type{cluster, 1}.prior, ...
            hmm_model_type{cluster, 1}.transmat, ...
            hmm_model_type{cluster, 1}.obsmat);
    end
end