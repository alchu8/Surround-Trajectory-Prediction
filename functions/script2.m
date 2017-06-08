%% get type indices
getType = [];
count = 0;
for type = 1:numel(trajectory_type)
    for data = 1:numel(trajectory_type{type})
        getType = [getType, type];
    end
end
%% train/test split

