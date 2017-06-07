function max_struct = get_max_cluster(LL, type)
% LL: generated from test_hmm_each.m, LL{type, 1}{cluster, 1} 
% is the log-likelihood of the data belonging to the hmm
% 
% max_struct: structure with maximum log-likelihood, and indices of the hmm
% (type, cluster)
    if nargin < 2
        type = false;
    end
    
    if type
        max_struct.cluster = 0;
        max_struct.max = -Inf;
        for c = 1:size(LL, 1)
            if max_struct.max < LL{c, 1}
                max_struct.max = LL{c, 1};
                max_struct.cluster = c;
            end
        end
    else
        max_struct.type = 0;
        max_struct.cluster = 0;
        max_struct.max = -Inf;
        for t = 1:size(LL, 1)
            for c = 1:size(LL{t, 1}, 1)
                if max_struct.max < LL{t, 1}{c, 1}
                    max_struct.max = LL{t, 1}{c, 1};
                    max_struct.type = t;
                    max_struct.cluster = c;
                end
            end
        end
    end
    
end