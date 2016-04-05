function top_pairs = putative_match(corners_distance, r_left, c_left, r_right, c_right)
% Select the top few hundred descriptor pairs with the smallest pairwise distances

% set top matches number
top = 160;

top_pairs = zeros(top, 4);

for i = 1:size(top_pairs, 1)
    [min_val, min_idx] = min(corners_distance(:));
    [min_left, min_right] = ind2sub(size(corners_distance),min_idx);
    
    top_pairs(i, :) = [r_left(min_left) c_left(min_left) r_right(min_right) c_right(min_right)];
    
    % set to infinity to ensure 
    corners_distance(min_left, :) = inf;
    corners_distance(:, min_right) = inf;

end