close all; dbstop error; clc;
[tracklet_files] = textread('../../data/tracklets/tracklet_list.txt', '%s');
%base_dir = '../../data/2011_09_26/2011_09_26_drive_0001_sync';
%calib_dir = '../../data/2011_09_26';
tracklets = cell(size(tracklet_files, 1), 1);
for i = 1:size(tracklet_files, 1)
    tracklets{i} = readTracklets(['../../data/tracklets' tracklet_files{i}]);
end
%tracklets = readTracklets([base_dir '/tracklet_labels.xml']); % slow version
%%
for tNum = 1:size(tracklets, 1)
    veh_type = cell(1, numel(tracklets{tNum}));
    tracklet_temp = tracklets{tNum};
    for it = 1:numel(tracklet_temp)
        veh_type{it} = tracklet_temp{it}.objectType;
    end
    veh_type = unique(veh_type);

    for type = 1:numel(veh_type)
        figure();
        for it = 1:numel(tracklet_temp)
            if strcmp(tracklet_temp{it}.objectType, veh_type(type)) == 1
                plot(tracklet_temp{it}.poses(1,:), tracklet_temp{it}.poses(2,:), '-o');
                hold on;
            end
        end
        hold off;
        xlim([0 100]);
        ylim([-30 30]);
        title(sprintf('Trajectory of surrounding %s for tracklet %i', string(veh_type(type)), tNum));
    end
end