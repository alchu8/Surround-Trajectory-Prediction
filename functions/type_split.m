function result = type_split(traj, traj_index, getType)
    uniq = unique(getType);
    result = cell(length(uniq), 1);
    for type = 1:numel(result)
        result{type} = cell(numel(traj), 1);
    end
    for cluster = 1:numel(traj)
        for data = 1:size(traj{cluster, 1}, 1)
            if data > numel(traj_index{cluster, 1})
                fprintf('data > index size when cluster=%i, data=%i', cluster, data);
            end
            type = getType(traj_index{cluster, 1}(data));
            result{type, 1}{cluster, 1}{end+1, 1} = traj{cluster, 1}{data, 1};
        end
    end
end