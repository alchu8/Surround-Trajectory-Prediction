function obs = map2Obs(x, y)
    multi_C = 10;
    x_max = 147.1436;
    x_min = -5.9188;
    y_max = 44.0645;
    y_min = -40.0455;
    
    if x < x_min
        x = x_min;
    elseif x > x_max
        x = x_max;
    end
    
    if y < y_min
        y = y_min;
    elseif y > y_max
        y = y_max;
    end

    %x_lim = round(multi_C*(x_max - x_min));
    y_lim = round(multi_C*(y_max - y_min));
    
    x_shift = -round(multi_C*x_min) + 1;
    y_shift = -round(multi_C*y_min) + 1;
    
    x = round(x*multi_C) + x_shift;
    y = round(y*multi_C) + y_shift;
    
    obs = y_lim*(x-1) + y;
end