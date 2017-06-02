function hmm_models = train_hmm(traj_obs_conf, O, Q, max_iter)

hmm_models = cell(size(traj_obs_conf, 1), 1);

% O and Q
% O = 12852;
% Q = 5;
% max_iter = 10;

for type = 1:size(hmm_models, 1)
    hmm_models{type, 1} = cell(size(traj_obs_conf{type, 1}, 1), 1);
    for cluster = 1:size(traj_obs_conf{type, 1}, 1)
        traj = traj_obs_conf{type, 1}{cluster, 1};
        % initial guessing
        prior1 = normalise(rand(Q,1));
        transmat1 = mk_stochastic(rand(Q,Q));
        obsmat1 = mk_stochastic(rand(Q,O));
        % improve guess of parameters using EM
        [LL, prior2, transmat2, obsmat2] = ...
            dhmm_em(traj, prior1, transmat1, obsmat1, 'max_iter', max_iter);
        % store values
        hmm_models{type, 1}{cluster, 1}.prior = prior2;
        hmm_models{type, 1}{cluster, 1}.transmat = transmat2;
        hmm_models{type, 1}{cluster, 1}.obsmat = obsmat2;
    end
end