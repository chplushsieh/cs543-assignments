
filedir = './assignment2_images';
filename = 'butterfly';
filepath = [filepath, filename, '.jpg'];

mode = 1; % 0 for downsample/upsample while 1 for increasing filter size

raw = imread(filepath);
[h, w]=size(raw);

img = im2double(rgb2gray(raw));
imshow(img);

% set the initial scale to 2, and use 10 levels in the scale pyramid
sigma = 2:11;
k = sigma ./ 2;

scale_space = zeros(h, w, 10); % [h,w] - dimensions of image, n - number of levels in scale space

logfilter = fspecial('log', [5 5], 2);

tic
for i = 1:size(k)
  if mode==0
    % downsample the image by a factor 1/k.
    % In that case, you will have to upsample the result
    downsampled = imresize(img, 1/k(i));
    upsampled = imresize(downsampled, k(i));

    % TODO Hint 1: think about whether you still need scale normalization
    % when you downsample the image
    % instead of increasing the scale of the filter.

    % TODO Hint 2: For the efficient implementation, pay attention to
    % the interpolation method you're using to upsample the filtered images
    % (see the options of the imresize function).
    % What kind of interpolation works best?

  elseif mode==1
    % TODO increases filter size
  end

  filtered = imfilter(img, logfilter,'replicate');
  imshow(filtered);
  scale_space(:, :, i) = filtered;
end
toc

% TODO set proper threshold
threshold = 10;
scale_space(scale_space<threshold) = 0;

% do nonmaximum suppression in each 2D slice
tic
for i = 1:size(scale_space, 3)
   suppressed = nlfilter(scale_space(:, :, i), [3 3], leave_max);
   % TODO try both
   % suppressed = ordfilt2(scale_space(:, :, i), 9, ones(3,3))
   % suppressed = colfilt(scale_space(:, :, i),[3 3],'sliding', leave_max);
   scale_space(:, :, i) = suppressed;
end
toc

% find max response for each pixel
blob = zeros(h, w);
for x = 1:size(scale_space, 1)
  for y = 1:size(scale_space, 2)
    [max_value, max_index] = max(scale_space(x, y, :));
    blob(x, y) = max_index;
  end
end

% draw blobs as circles
[blob_x, blob_y, blob_rad] = find(blob);
show_all_circles(raw, blob_x, blob_y, blob_rad);
