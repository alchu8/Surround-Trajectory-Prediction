function [obs, obs_num] = map2Obs(x, y, multi_C)
% map a pair of (x, y) to an observation label.
% x and y will be multiply by multi_C before rounded, increase multi_C will
% also increase obs_num (number of total observations) by square, the
% default multi_C is 1.
    
    if nargin < 3
        multi_C = 1;
    end
    
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

    x_lim = round(multi_C*(x_max - x_min));
    y_lim = round(multi_C*(y_max - y_min));
    obs_num = x_lim*y_lim;
    
    x_shift = -round(multi_C*x_min) + 1;
    y_shift = -round(multi_C*y_min) + 1;
    
    x = round(x*multi_C) + x_shift;
    y = round(y*multi_C) + y_shift;
    
    obs = y_lim*(x-1) + y;
end