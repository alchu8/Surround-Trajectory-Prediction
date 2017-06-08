%
function result = type_split(traj, traj_index, getType)
    uniq = unique(getType);
    result = cell(length(uniq), 1);
    for type = 1:numel(result)
        result{type} = cell(numel(traj), 1);
    end
    for cluster = 1:numel(traj)
        for data = 1:traj{cluster, 1}
            type = getType(traj_index{cluster, 1}{data, 1});
            if numel(result{type, 1}{cluster, 1}) == 0
                result{type, 1}{cluster, 1} = {traj{cluster, 1}{data, 1}};
            else
                result{type, 1}{cluster, 1} = {result{type, 1}{cluster, 1};...
                    traj{cluster, 1}{data, 1}};
            end
        end
    end
end