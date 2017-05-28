close all; dbstop error; clc;
base_dir = '../../data/2011_09_26/2011_09_26_drive_0001_sync';
%calib_dir = '../../data/2011_09_26';

tracklets = readTracklets([base_dir '/tracklet_labels.xml']); % slow version
%%
veh_type = {};
for it = 1:numel(tracklets)
    veh_type{it} = tracklets{it}.objectType;
end
veh_type = unique(veh_type);
%%

for type = 1:numel(veh_type)
    figure();
    for it = 1:numel(tracklets)
        if strcmp(tracklets{it}.objectType, veh_type(type)) == 1
            plot(tracklets{it}.poses(1,:), tracklets{it}.poses(2,:), '-o');
            hold on;
        end
    end
    hold off;
    xlim([0 100]);
    ylim([-30 30]);
    title(sprintf('Trajectory of surrounding %s', string(veh_type(type))));
end