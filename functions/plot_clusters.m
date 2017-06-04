function plot_clusters(traj, cell_out, per)
% plot trajectory clusters for specific vehicle type
% traj: trajectory of specific type, i.e. trajectory_type{1}
% cell_out: output of Cluster2Cell.m
% per: boolean value to plot one figure per cluster or one figure for all
% clusters

    if per == true
        for i = 1:size(cell_out, 1) % ith cluster
            figure; hold on;
            color = rand(1,3);
            for n = cell_out{i} % nth trajectory
                plot(traj{n, 1}(1, :), traj{n ,1}(2, :), 'Color', color);
                plot(traj{n, 1}(1, 1), traj{n ,1}(2, 1), 'Color', color, 'Marker', '*');
            end
            hold off;
        end
    else
        figure; hold on;
        for i = 1:size(cell_out, 1)
            color = rand(1,3);
            for n = cell_out{i}
                plot(traj{n, 1}(1, :), traj{n ,1}(2, :), 'Color', color);
                plot(traj{n, 1}(1, 1), traj{n ,1}(2, 1), 'Color', color, 'Marker', '*');
            end
        end
        hold off;
        title(sprintf('%i clusters', size(cell_out, 1)));
    end
end