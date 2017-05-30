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