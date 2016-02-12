function [albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs)
% imarray: h x w x Nimages array of Nimages no. of images
% light_dirs: Nimages x 3 array of light source directions
% albedo_image: h x w image
% surface_normals: h x w x 3 array of unit surface normals

[h, w, Nimages] = size(imarray);

% ipix: Nimages x (h w)
ipix = transpose(reshape(imarray, (h*w), Nimages));

% gpix: 3 x (h w)
gpix = light_dirs \ ipix;

% g: 3 x h x w
g = reshape(gpix, 3, h, w);

% g: h x w x 3
g = permute(g, [2 3 1]);

gx = g(:, :, 1);
gy = g(:, :, 2);
gz = g(:, :, 3);
albedo_image = sqrt(gx.^2 + gy.^2 + gz.^2);

surface_normals = bsxfun(@rdivide, g, albedo_image);
end
