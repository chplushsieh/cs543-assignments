function F = fit_fundamental(matches, is_normalized)
% input  matches      : Nx4 matched points in image 1&2
% input  is_normalized: 1 for normalized 8 point algorithm while 
%                       0 for un-normalized one
% output F            : 3x3 fundamental matrix

N = size(matches,1);

% 3xN homogeneous coordinates of matched points in image 1
x1 = [transpose(matches(:, 1:2)); ones(1, N)];

% 3xN homogeneous coordinates of matched points in image 2
x2 = [transpose(matches(:, 3:4)); ones(1, N)];

if is_normalized
    normalization_x1 = normalization_matrix(x1);
    normalization_x2 = normalization_matrix(x2);

    x1 = normalization_x1 * x1;
    x2 = normalization_x2 * x2;
end

% solve linear system
W = [ repmat(x2(1,:)',1,3) .* x1', repmat(x2(2,:)',1,3) .* x1', x1(1:3,:)'];
[~,~,V] = svd(W);
fs_array = V(:,end);
fs = reshape(fs_array,3,3)';

% enforce the rank-2 constraint
[u,s,v] = svd(fs);
s_rank2 = diag([s(1) s(5) 0]); % throw out the smallest singular value 
F = u * s_rank2 * (v'); 

if is_normalized
    F = normalization_x2' * F * normalization_x1;
end

end