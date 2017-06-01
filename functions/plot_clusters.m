function plot_clusters(traj, cell_out, per)
% plot trajectory clusters for specific vehicle type
% traj: trajectory of specific type, i.e. trajectory_type{1}
% cell_out: output of Cluster2Cell.m
% per: boolean value to decide plot figure per cluster or one figure of all
% clusters

    if per == true
        for i = 1:size(cell_out, 1)
            figure;
            color = rand(1,3);
            for n = cell_out{i}
                plot(traj{n, 1}(1, :), traj{n ,1}(2, :), 'Color', color, 'Marker', '*', 'MarkerIndices', 1);
                hold on;
            end
            hold off;
        end
    else
        figure;
        for i = 1:size(cell_out, 1)
            color = rand(1,3);
            for n = cell_out{i}
                plot(traj{n, 1}(1, :), traj{n ,1}(2, :), 'Color', color, 'Marker', '*', 'MarkerIndices', 1);
                hold on;
            end
        end
        hold off;
        title(sprintf('%i clusters', size(cell_out, 1)));
    end
end