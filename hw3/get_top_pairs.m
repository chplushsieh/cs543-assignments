function [top_pairs] = get_top_pairs(img_left, img_right)
% output top_pairs: Nx4 matrix with each row is a pair of the form:
% [ row_left col_left row_right col_right ]

% set harris detector parameters
[cim_left, r_left, c_left] = harris(img_left, 3, 0.005, 1, 0);
[cim_right, r_right, c_right] = harris(img_right, 3, 0.005, 1, 0);

% set neighbor size
neighbor_size = 15;

[r_left, c_left] = remove_near_boundary(r_left, c_left, img_left, neighbor_size);
[r_right, c_right] = remove_near_boundary(r_right, c_right, img_right, neighbor_size);

corner_neighbors_left = get_corner_descriptor(neighbor_size, img_left, r_left, c_left);
corner_neighbors_right = get_corner_descriptor(neighbor_size, img_right, r_right, c_right);

corners_distance = dist2(corner_neighbors_left, corner_neighbors_right);

top_pairs = putative_match(corners_distance, r_left, c_left, r_right, c_right);

end