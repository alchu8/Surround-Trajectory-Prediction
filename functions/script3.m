for type = 1:numel(trajectory_type)
    figure;
    traj_type = trajectory_type{type};
    for cell = 1:numel(traj_type)
        plot_traj(traj_type{cell}, cell);
        w = waitforbuttonpress;
        if w 
            clf;
        end
    end
end
%%
traj = trajectory_type{1, 1}{1, 1};
figure;
plot(traj(1, 1:10), traj(2, 1:10), 'Marker', '*');
grid on;
title('Mapping to observations with high sampling rate');
xlabel('x position');
ylabel('y position');
set(gca,'xtick',0:5:100,'ytick',0:0.1:100);

figure;
plot(traj(1, 1:10), traj(2, 1:10), 'Marker', '*');
grid on;
title('Mapping to observations with low sampling rate');
xlabel('x position');
ylabel('y position');
set(gca,'xtick',0:8:100,'ytick',0:0.2:100);
