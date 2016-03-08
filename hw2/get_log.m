function [ logfilter ] = get_log( sigma, i )
% 
filter_size = 2*ceil(3*sigma(i))+1;
logfilter = sigma(i)^2 * fspecial('log', filter_size, sigma(i));
end

