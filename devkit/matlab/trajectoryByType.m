%function output = trajectoryByType(tracklet_folder_dir)
    %if nargin < 1
        tracklet_folder_dir = '../../data/tracklets';
    %end
    [tracklet_files] = textread(strcat(tracklet_folder_dir, '/tracklet_list.txt'), '%s');
    tracklets = cell(size(tracklet_files, 1), 1);
    for i = 1:size(tracklet_files, 1)
        tracklets{i} = readTracklets([tracklet_folder_dir tracklet_files{i}]);
    end
    
    veh_type = {'Car' 'Van' 'Truck' 'Pedestrian' 'Person (sitting)' 'Cyclist' 'Tram' 'Misc'}; 
    %%
    trajectory_type = cell(numel(veh_type),1);
    for type = 1:numel(veh_type)
        for dataNum = 1:size(tracklets, 1)
            tracklet_temp = tracklets{dataNum};
            for vehNum = 1:size(tracklet_temp, 1)
                if strcmp(tracklet_temp{vehNum}.objectType, veh_type(type)) == 1
                    trajectory_type{type, 1}{1+end, 1} = tracklet_temp{vehNum}.poses(1:2,:);
                end
            end
        end
    end
    clear tracklet_temp;
    %%
    for type = 1:numel(veh_type)
        figure();
        for vehNum = 1:size(trajectory_type{type, 1}, 1)
            plot(trajectory_type{type, 1}{vehNum, 1}(1, :), trajectory_type{type, 1}{vehNum, 1}(2, :), '-*', 'MarkerIndices', [1]);%, '-o', 'MarkerIndices', 2:size(trajectory_type{type, 1}{vehNum, 1},2));
            hold on;
        end
        hold off;
        ylim([-50 50]);
        xlim([-50 200]);
        title(sprintf('Trajectory of surrounding %s', veh_type{type}));
    end
    
    
%end