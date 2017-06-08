%cell_in should be trajectory_data
%out: n*(n-1)/2 by 1 array of distances
function out = mypDist(cell_in)
    out = zeros(numel(cell_in)*(numel(cell_in)-1)/2, 1);
    count = 1;
    for i = 1:numel(cell_in)
        a = cell_in{i, 1}(1:2, :)'; % get x and y vectors
        for j = i+1:numel(cell_in)
            b = cell_in{j, 1}(1:2, :)';
            out(count) = MatLabLCSS(a, b, 1, 1);
            count = 1 + count;
        end
    end
end