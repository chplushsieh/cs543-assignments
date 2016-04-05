function [L] = get_epipolar_line(F, matches)
% transform points from 
% the first image to get epipolar lines in the second image
N = size(matches,1);

L = (F * [matches(:,1:2) ones(N,1)]')'; 
end

