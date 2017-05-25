close all; dbstop error; clc;
base_dir = '../../data/2011_09_26/2011_09_26_drive_0001_sync';
calib_dir = '../../data/2011_09_26';

tracklets = readTracklets([base_dir '/tracklet_labels.xml']); % slow version

%%
figure();
for it = 1:numel(tracklets)
    if strcmp(tracklets{it}.objectType, 'Car') == 1
        plot(tracklets{it}.poses(1,:), tracklets{it}.poses(2,:), '-o');
        hold on;
    end
end
hold off;