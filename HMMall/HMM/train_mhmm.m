function hmm_models = train_mhmm(data, O, Q, M, max_iter)

hmm_models = cell(size(data, 1), 1);


for type = 1:size(hmm_models, 1)
    hmm_models{type, 1} = cell(size(data{type, 1}, 1), 1);
    for cluster = 1:size(data{type, 1}, 1)
        traj = data{type, 1}{cluster, 1};
        % initial guessing
        prior1 = normalise(rand(Q,1));
        transmat1 = mk_stochastic(rand(Q,Q));
        con_mat = [];
        for n = 1:size(traj, 1)
            con_mat = horzcat(con_mat, traj{n, 1});
        end
        indices = randperm(size(con_mat, 2));
        mu1 = reshape(con_mat(:,indices(1:(Q*M))), [O Q M]);
        Sigma1 = repmat(eye(O), [1 1 Q M]);
        mixmat1 = mk_stochastic(rand(Q,M));
        % improve guess of parameters using EM
        [~, prior2, transmat2, mu2, Sigma2, mixmat2] = ...
            mhmm_em(traj, prior1, transmat1, mu1, Sigma1, mixmat1, 'max_iter', max_iter);
        % store values
        hmm_models{type, 1}{cluster, 1}.prior = prior2;
        hmm_models{type, 1}{cluster, 1}.transmat = transmat2;
        hmm_models{type, 1}{cluster, 1}.mu = mu2;
        hmm_models{type, 1}{cluster, 1}.sigma = Sigma2;
        hmm_models{type, 1}{cluster, 1}.mixmat = mixmat2;
    end
end