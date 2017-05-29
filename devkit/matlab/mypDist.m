%cell_in should be trajectory_type{type_number, 1}
%out: n*(n-1)/2 by 1 array of distances
function out = mypDist(cell_in)
    out = zeros(numel(cell_in)*(numel(cell_in)-1)/2, 1);
    count = 1;
    for i = 1:numel(cell_in)
        a = cell_in{i, 1}';
        for j = i+1:numel(cell_in)
            b = cell_in{j, 1}';
            out(count) = MatLabLCSS(a, b, 3, 5);
            count = 1 + count;
        end
    end
end