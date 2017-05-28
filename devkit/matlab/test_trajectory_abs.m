close all; dbstop error; clc;
base_dir = '../../data/2011_09_26/2011_09_26_drive_0001_sync';
calib_dir = '../../data/2011_09_26';
oxts = loadOxtsliteData(base_dir);
tracklets = readTracklets([base_dir '/tracklet_labels.xml']); % slow version

%%
veh_type = cell(numel(tracklets), 1);
for it = 1:numel(tracklets)
    veh_type{it} = tracklets{it}.objectType;
end
veh_type = unique(veh_type);
ego_position = cell(numel(tracklets), 1);
for it = 1:numel(oxts)
    ego_position{it} = oxts{it}(1:2);
end
pose = convertOxtsToPose(oxts);

%%
for type = 1:numel(veh_type)
    figure();
    for it = 1:numel(tracklets)
        if strcmp(tracklets{it}.objectType, veh_type(type)) == 1
            %figure();
            start = tracklets{it}.first_frame;
            B = zeros(4, size(tracklets{it}.poses, 2));
            for i = 1:size(tracklets{it}.poses, 2)
                A = [tracklets{it}.poses(1,i) tracklets{it}.poses(2,i) 0 1]';
                B(:, i) = pose{i+start}*A;
                %if i == 1
                %    plot(B(1), B(2), 'x');
                %else
                %    plot(B(1), B(2), '-o');
                %end
                %hold on;
            end
            plot(B(1, :), B(2, :), '-o');
            hold on;
            %hold off;
            %xlim([0 200]);
            %ylim([-20 20]);
        end
    end
    hold off;
    xlim([0 200]);
    ylim([-20 20]);
    title(sprintf('Trajectory of surrounding %s', string(veh_type(type))));
end