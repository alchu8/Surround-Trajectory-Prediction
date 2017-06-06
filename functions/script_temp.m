%%
traj = trajectory_type{2, 1};
%figure();
for i = 1:size(cell_out, 1)
    figure(); hold on;
    color = rand(1,3);
    for n = cell_out{i}
        plot(traj{n, 1}(1, :), traj{n ,1}(2, :), 'Color', color);
        plot(traj{n, 1}(1, 1), traj{n ,1}(2, 1), 'Color', color, 'Marker', '*');
    end
    hold off;
end
hold off;

%%
W_all = cell(8, 1);
load('W_car.mat');
load('W_van.mat');
load('W_trk.mat');
load('W_ped.mat');
load('W_psn.mat');
load('W_cyc.mat');
load('W_trm.mat');
load('W_mix.mat');

W_all{1} = W_car;
W_all{2} = W_van;
W_all{3} = W_trk;
W_all{4} = W_ped;
W_all{5} = W_psn;
W_all{6} = W_cyc;
W_all{7} = W_trm;
W_all{8} = W_mix;

%%
load('W_all.mat');
load('trajectory_type.mat');
veh_type = 4;
W_now = W_all{veh_type};
for k = 20
    [Center, member_hard, membership_value] = SpectralClustering(W_now, k, 3);
    plot_clusters(trajectory_type{veh_type}, Cluster2Cell(member_hard, membership_value, 0.9), true);
end
%% cluster trajectories with initial k's
traj_clustered = get_clustered_traj(trajectory_type, W_all, [50, 20, 10, 30, 10, 15, 5, 5]);
%%
x = [];
y = [];

for type = 1:size(trajectory_type, 1)
    trajPerType = trajectory_type{type};
    for car = 1:size(trajPerType, 1)
        trajSpecific = trajPerType{car};
        x = [x, trajSpecific(1, :)];
        y = [y, trajSpecific(2, :)];
    end
end
%x = round(x.*10) + 60;
%y = round(y.*10) + 401;

x_min = min(x);
x_max = max(x);
x_std = std(x);
x_uniq = unique(x);
y_min = min(y);
y_max = max(y);
y_std = std(y);
y_uniq = unique(y);

%%
O = zeros(length(x), 1);
for i = 1:length(x)
    O(i) = map2Obs(x(i), y(i));
end

O_max = max(O);
O_min = min(O);
O_uniq = unique(O);
%% mapping trajectories from {x, y} to {obs_label}
[traj_clustered_obs, obs_num] = map2Obs(traj_clustered);

%% split into training and testing set
[trainset, testset] = train_test_split(traj_clustered_obs, 0.75);

%% train hmm on each cluster
hmm_models = train_hmm(trainset, obs_num, 5, 10);

%% retrieve max struct for each test trajectory
LL_all_max = test_hmm_all_max(testset, hmm_models);

% validation without type
err_cnt = 0; % misclassifications
count = 0; % total number of test trajectories
for type = 1:size(LL_all_max, 1)
    for cluster = 1:size(LL_all_max{type, 1}, 1)
        for data = 1:size(LL_all_max{type, 1}{cluster, 1}, 1)
            count = count + 1;
            if LL_all_max{type, 1}{cluster, 1}{data, 1}.type ~= type...
                    || LL_all_max{type, 1}{cluster, 1}{data, 1}.cluster ~= cluster
                err_cnt = err_cnt + 1;
                %sprintf("error: in type=%i, cluster=%i...data=%i, type=%i, cluster=%i",...
                    %type, cluster, data, LL_all_max{type, 1}{cluster, 1}{data, 1}.type, LL_all_max{type, 1}{cluster, 1}{data, 1}.cluster)
            end
        end
    end
end
sprintf('The error rate of predicting without type: %f', err_cnt/count)
%% validation with type
LL_all_max = test_hmm_all_max(testset, hmm_models, true);

err_cnt = 0; % misclassifications
count = 0; % total number of test trajectories
for type = 1:size(LL_all_max, 1)
    for cluster = 1:size(LL_all_max{type, 1}, 1)
        for data = 1:size(LL_all_max{type, 1}{cluster, 1}, 1)
            count = count + 1;
            if LL_all_max{type, 1}{cluster, 1}{data, 1}.cluster ~= cluster
                err_cnt = err_cnt + 1;
                %sprintf("error: in type=%i, cluster=%i...data=%i, type=%i, cluster=%i",...
                    %type, cluster, data, LL_all_max{type, 1}{cluster, 1}{data, 1}.type, LL_all_max{type, 1}{cluster, 1}{data, 1}.cluster)
            end
        end
    end
end
sprintf('The error rate of predicting with type: %f', err_cnt/count)
%% get max average LL
[LL_avg_all, LL_avg_all_index] = get_avg_LL_all(testset, hmm_models);
% validation
err_cnt = 0;
count = 0;
for type = 1:size(LL_avg_all, 1)
    for cluster = 1:size(LL_avg_all{type, 1}, 1)
        for data = 1:size(LL_avg_all{type, 1}{cluster, 1}, 1)
            count = count + 1;
            if LL_avg_all_index{type, 1}{cluster, 1}{data, 1} ~= type
                err_cnt = err_cnt + 1;
            end
        end
    end
end
sprintf('The error rate of predicting type by avg: %f', err_cnt/count)
%% test by averaging types
[~, LL_avg_all_index] = get_avg_LL_all(testset, hmm_models);
result = test_by_avgtype(testset, LL_avg_all_index, hmm_models);
% validation
err_cnt = 0; % misclassifications
count = 0; % total number of test trajectories
for type = 1:size(result, 1)
    for cluster = 1:size(result{type, 1}, 1)
        for data = 1:size(result{type, 1}{cluster, 1}, 1)
            count = count + 1;
            if result{type, 1}{cluster, 1}{data, 1}.type ~= type...
                    || result{type, 1}{cluster, 1}{data, 1}.cluster ~= cluster
                err_cnt = err_cnt + 1;
                %sprintf("error: in type=%i, cluster=%i...data=%i, type=%i, cluster=%i",...
                    %type, cluster, data, LL_all_max{type, 1}{cluster, 1}{data, 1}.type, LL_all_max{type, 1}{cluster, 1}{data, 1}.cluster)
            end
        end
    end
end
sprintf('The error rate by deciding type by avg: %f', err_cnt/count)








