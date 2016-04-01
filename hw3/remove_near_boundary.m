function [r, c] = remove_near_boundary(r, c, img, neighbor_size);

[h, w] = size(img);

c(r <= neighbor_size) = [];
r(r <= neighbor_size) = [];

r(c <= neighbor_size) = [];
c(c <= neighbor_size) = [];

c(r >= h - neighbor_size) = [];
r(r >= h - neighbor_size) = [];

r(c >= w - neighbor_size) = [];
c(c >= w - neighbor_size) = [];

end