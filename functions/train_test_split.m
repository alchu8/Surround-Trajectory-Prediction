function [train, test] = train_test_split(traj, train_ratio)
% traj: trajectory to split
% train_ratio: ratio of training size
% [train, test]: splitted two dataset
    train = cell(size(traj, 1), 1);
    test = cell(size(traj, 1), 1);
    for type = 1:size(traj, 1)
        train{type, 1} = cell(size(traj{type, 1}, 1), 1);
        test{type, 1} = cell(size(traj{type, 1}, 1), 1);
        for cluster = 1:size(traj{type, 1}, 1)
            data_num = size(traj{type, 1}{cluster, 1}, 1);
            train_size = ceil(train_ratio*data_num);
            shuffle_index = randperm(data_num);
            train_index = shuffle_index(1:train_size);
            test_index = shuffle_index(train_size+1:end);
            
            train{type, 1}{cluster, 1} = cell(length(train_index), 1);
            for data = 1:length(train_index)
                train{type, 1}{cluster, 1}{data, 1} = ...
                    traj{type, 1}{cluster, 1}{train_index(data), 1};
            end
            
            test{type, 1}{cluster, 1} = cell(length(test_index), 1);
            for data = 1:length(test_index)
                test{type, 1}{cluster, 1}{data, 1} = ...
                    traj{type, 1}{cluster, 1}{test_index(data), 1};
            end
        end
    end
end