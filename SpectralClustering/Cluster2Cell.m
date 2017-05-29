function cell_out = Cluster2Cell(C)
    k = size(C, 2);
    cell_out = cell(k, 1);
    for i = 1:k
        k_ele = [];
        for j = 1:size(C, 1)
            if C(j, i) == 1
                k_ele = [k_ele, j];
            end
        end
        cell_out{i, 1} = k_ele;
    end
end