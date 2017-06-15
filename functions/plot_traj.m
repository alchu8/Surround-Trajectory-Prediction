function plot_traj(traj, cell)
    title(sprintf('%i', cell));
    hold on;
    plot(traj(1, :), traj(2, :));
    plot(traj(1, 1), traj(2, 1), 'Marker', '*');
    plot(0, 0, 'Marker', 'x');
    hold off;
end