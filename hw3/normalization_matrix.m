function [normalization] = normalization_matrix(x)
% input x: 3xN homogeneous coordinates
% output normalization: 3x3 matrix that can normalize x to have
% an average distance of sqrt(2) to origin
centroid = mean(x,2);
dists = sqrt(sum((x - repmat(centroid,1,size(x,2))).^2,1));
mean_dist = mean(dists);
normalization = [sqrt(2)/mean_dist 0 -sqrt(2)/mean_dist*centroid(1);...
                 0 sqrt(2)/mean_dist -sqrt(2)/mean_dist*centroid(2);...
                 0 0 1];
end





