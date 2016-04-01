
function corner_neighbors = get_corner_descriptor(neighbor_size, img, r, c)

corner_neighbors = zeros(size(r, 1), neighbor_size^2);

for corner = 1:size(r, 1)
    neighbor = flat_neighbor(img, r(corner), c(corner), neighbor_size);
    
    % make it zero-mean
    neighbor = neighbor - mean(neighbor(:));
    
    % make it unit variance
    neighbor = neighbor / std(neighbor(:));

    corner_neighbors(corner, :) = neighbor;
end

end