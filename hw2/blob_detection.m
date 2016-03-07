
filedir = './assignment2_images';
filename = 'butterfly';
filepath = [filepath, filename, '.jpg'];

raw = imread(filepath);
[h, w]=size(raw);

img = im2double(rgb2gray(raw));
imshow(img);

% set the initial scale to 2, and use 10 levels in the scale pyramid
sigma = 2:11;
k = sigma ./ 2;

scale_space = zeros(h, w, 10); % [h,w] - dimensions of image, n - number of levels in scale space

logfilter = fspecial('log', [5 5], 2);

% downsample the image by a factor 1/k.
% In that case, you will have to upsample the result
for i = 1:size(k)
  downsampled = imresize(img, 1/k(i));
  upsampled = imresize(downsampled, k(i));
  filtered = imfilter(img, logfilter,'replicate');
  imshow(filtered);
  scale_space(:, :, i) = filtered;
end

% TODO set threshold
threshold = 10;
scale_space(scale_space<threshold) = 0;

% do nonmaximum suppression in each 2D slice
for i = 1:size(scale_space, 3)
   suppressed = nlfilter(scale_space(:, :, i), [3 3], leave_max);
   % TODO try colfilt and ordfilt2
   scale_space(:, :, i) = suppressed;
end

% find max response for each pixel
blob = zeros(h, w);
for x = 1:size(scale_space, 1)
  for y = 1:size(scale_space, 2)
    [max_value, max_index] = max(scale_space(x, y, :));
    blob_radius(x, y) = max_index;
  end
end


% draw blobs as circles
[blob_x, blob_y, blob_rad] = find(blob);
show_all_circles(raw, blob_x, blob_y, blob_rad);
