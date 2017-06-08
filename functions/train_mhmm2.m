function hmm_models = train_mhmm2(data, O, Q, M, max_iter)

hmm_models = cell(size(data, 1), 1);

for cluster = 1:size(hmm_models, 1)
    if numel(data{cluster, 1}) == 0
        continue;
    end
    
    % initial guessing
    prior1 = normalise(rand(Q,1));
    transmat1 = mk_stochastic(rand(Q,Q));
    con_mat = [];
    for n = 1:size(data{cluster, 1}, 1)
        con_mat = horzcat(con_mat, data{cluster, 1}{n, 1});
    end
    indices = randperm(size(con_mat, 2));
    if Q*M > length(indices)
        fprintf('cluster=%i, length=%i\n', cluster, length(indices));
    end
    mu1 = reshape(con_mat(:,indices(1:(Q*M))), [O Q M]);
    Sigma1 = repmat(eye(O), [1 1 Q M]);
    mixmat1 = mk_stochastic(rand(Q,M));
    
    % improve guess of parametersusing EM
    [~, prior2, transmat2, mu2, Sigma2, mixmat2] = ...
        mhmm_em(data{cluster, 1}, prior1, transmat1, mu1, Sigma1, mixmat1, 'max_iter', max_iter);
    
    % store values
    hmm_models{cluster, 1}.prior = prior2;
    hmm_models{cluster, 1}.transmat = transmat2;
    hmm_models{cluster, 1}.mu = mu2;
    hmm_models{cluster, 1}.sigma = Sigma2;
    hmm_models{cluster, 1}.mixmat = mixmat2;
end