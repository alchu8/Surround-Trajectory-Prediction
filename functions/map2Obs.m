function [traj_clustered_obs, obs_num] = map2Obs(traj_clustered, multi_C)
% map each pair of (x, y) to an observation label.
% traj_clustered: trajectories organized into clusters in 2 x T
% x and y will be multiplied by multi_C before rounded, increase multi_C will
% also increase obs_num (number of total observations) by square, the
% default multi_C is 1.
% returns cell structure in same format with trajectories in 1 x T
    
    if nargin < 2
        multi_C = 1;
    end
    
    x_max = -Inf;
    x_min = Inf;
    y_max = -Inf;
    y_min = Inf;
    % find max and min in the entire dataset
    for i = 1:size(traj_clustered) % veh type
        for j = 1:size(traj_clustered{i, 1}, 1) % cluster
            for k = 1:size(traj_clustered{i, 1}{j, 1}, 1) % traj in cluster
                x = traj_clustered{i, 1}{j, 1}{k, 1}(1, :);
                y = traj_clustered{i, 1}{j, 1}{k, 1}(2, :);
                x_max = max([x x_max]); % running max
                x_min = min([x x_min]); % running min
                y_max = max([y y_max]);
                y_min = min([y y_min]);
            end
        end
    end

    x_offset = -round(multi_C*x_min) + 1;
    y_offset = -round(multi_C*y_min) + 1;
    
    x_range = round(multi_C*x_max) + x_offset
    y_range = round(multi_C*y_max) + y_offset
    obs_num = x_range*y_range;
    
    traj_clustered_obs = traj_clustered;
    % map 2 x T to 1 x T
    for i = 1:size(traj_clustered) % veh type
        for j = 1:size(traj_clustered{i, 1}, 1) % cluster
            for k = 1:size(traj_clustered{i, 1}{j, 1}, 1) % traj in cluster
                x = traj_clustered{i, 1}{j, 1}{k, 1}(1, :);
                y = traj_clustered{i, 1}{j, 1}{k, 1}(2, :);
                x = round(x*multi_C) + x_offset;
                y = round(y*multi_C) + y_offset;
                obs = y_range*(x-1) + y; % 1 x T
                traj_clustered_obs{i, 1}{j, 1}{k, 1} = obs;
            end
        end
    end
end