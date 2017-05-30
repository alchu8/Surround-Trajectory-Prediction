%%
traj = trajectory_type{2, 1};
%figure();
for i = 1:size(cell_out, 1)
    figure();
    color = rand(1,3);
    for n = cell_out{i}
        plot(traj{n, 1}(1, :), traj{n ,1}(2, :), 'Color', color, 'Marker', '*', 'MarkerIndices', 1);
        hold on;
    end
    hold off;
end
hold off;

%%
W_all = cell(8, 1);
load('W_cars.mat');
load('W_van.mat');
load('W_trk.mat');
load('W_ped.mat');
load('W_psn.mat');
load('W_cyc.mat');
load('W_trm.mat');
load('W_mix.mat');

W_all{1} = W;
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
veh_type = 2;
W_now = W_all{veh_type};
for k = 10
    [Center, member_hard, membership_value] = SpectralClustering(W_now, k, 3);
    plot_clusters(trajectory_type{veh_type}, Cluster2Cell(member_hard), false);
end
