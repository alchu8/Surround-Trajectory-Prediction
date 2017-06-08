%% get type indices
getType = [];
for type = 1:numel(trajectory_type)
    for data = 1:numel(trajectory_type{type})
        getType = [getType, type];
    end
end
%% plot
[traj_clustered, traj_clustered_ind] = get_clustered_traj(trajectory_data, W, 100);
%% train/test split
train_ratio = 0.75;
[train, test, train_index, test_index] = train_test_split2(traj_clustered, traj_clustered_ind, train_ratio);
%% train on entire dataset
O = 4; Q = 3; M = 2; max_iter = 20;
hmm_models = train_mhmm2(train, O, Q, M, max_iter);
%% test
LL_all = test_mhmm_all2(test, hmm_models);
fprintf('done testing\n');
% testing error
err = 0;
count = 0;
for cluster = 1:numel(LL_all)
    for data = 1:numel(LL_all{cluster, 1})
        count = count + 1;
        if LL_all{cluster, 1}{data, 1}.cluster ~= cluster
            err = err + 1;
        end
    end
end
fprintf('Error = %f\n', err/count);

%% split by type
train_new = type_split(train, train_index, getType);
test_new = type_split(test, test_index, getType);
fprintf('done splitting by type\n');

%% train by type
hmm_type = cell(8, 1);
for type = 1:numel(hmm_type)
    hmm_type{type} = train_mhmm2(train_new{type}, O, Q, M, max_iter);
end
fprintf('done training by type\n');
%% test seperately
err_all = 0;
count_all = 0;
LL_all = cell(numel(hmm_type), 1);
for type = 1:numel(hmm_type)
    LL_all{type, 1} = test_mhmm_all2(test_new{type, 1}, hmm_type{type});
    err = 0;
    count = 0;
    for cluster = 1:numel(LL_all{type, 1})
        for data = 1:numel(LL_all{type, 1}{cluster, 1})
            count = count + 1;
            if LL_all{type, 1}{cluster, 1}{data, 1}.cluster ~= cluster
                err = err + 1;
            end
        end
    end
    err_all = err_all + err;
    count_all = count_all + count;
    fprintf('type = %i, Error = %f\n', type, err/count);
end
fprintf('overall, Error = %f\n', err_all/count_all);




