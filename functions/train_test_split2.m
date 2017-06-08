function [train, test, train_index, test_index] = train_test_split2(traj, traj_index, train_ratio)
    train = cell(numel(traj), 1);
    test = cell(numel(traj), 1);
    train_index = cell(numel(traj), 1);
    test_index = cell(numel(traj), 1);
    
    for cluster = 1:numel(traj)
        data_num = numel(traj{cluster});
        cut = int(data_num*train_ratio);
        indices = randperm(data_num);
        train{cluster} = cell(cut, 1);
        test{cluster} = cell(data_num - cut, 1);
        train_index{cluster} = cell(cut, 1);
        test_index{cluster} = cell(data_num - cut, 1);
        for data = 1:cut
            train{cluster, 1}{data, 1} = traj{cluster, 1}{indices(data), 1};
            train_index{cluster, 1}{data, 1} = traj_index{cluster, 1}{indices(data), 1};
        end
        for data = 1:data_num - cut
            test{cluster, 1}{data, 1} = traj{cluster, 1}{indices(data+cut), 1};
            test_index{cluster, 1}{data, 1} = traj_index{cluster, 1}{indices(data+cut), 1};
        end
    end
end