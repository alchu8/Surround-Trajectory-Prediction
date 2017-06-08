function max_struct = get_max_cluster2(LL)
    
    
    %max_struct.type = 0;
    max_struct.cluster = 0;
    max_struct.max = -Inf;
    
    for c = 1:size(LL, 1)
        if max_struct.max < LL{c, 1}
            max_struct.max = LL{c, 1};
            %max_struct.type = t;
            max_struct.cluster = c;
        end
    end
    
end