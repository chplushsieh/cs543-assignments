close all;
clearvars;

filedir = './assignment2_images/';
filename = 'butterfly';
filepath = [filedir, filename, '.jpg'];

mode = 0; % 0 for downsample/upsample while 1 for increasing filter size

% set the initial scale to 2, and use 10-15 levels in the scale pyramid
sigma = zeros(1, 12);
sigma(1) = 2;
k = 1.25;
for i = 2:size(sigma,2)
    sigma(i) = sigma(i-1) * k;
end

raw = imread(filepath);

img = im2double(rgb2gray(raw));
[h, w]=size(img); % [h,w] - dimensions of image

scale_space = zeros(h, w, size(sigma, 2));

logfilter = get_log( sigma, 1 );

tic
for i = 1:size(sigma,2)
  if mode==0
    downsampled = imresize(img, 1/(k^(i-1)));
    
    filtered = imfilter(downsampled, logfilter, 'replicate');
    filtered = filtered .^ 2;
    
    upsampled = imresize(filtered, [h, w], 'bicubic');
%     % see filtered results
%     figure; imshow(upsampled, [min(upsampled(:)) max(upsampled(:))])
    scale_space(:, :, i) = upsampled;

  elseif mode==1
    logfilter = get_log( sigma, i );

    filtered = imfilter(img, logfilter, 'replicate');
    filtered = filtered .^ 2;
%     % see filtered results
%     figure; imshow(filtered, [min(filtered(:)) max(filtered(:))])
    scale_space(:, :, i) = filtered;
  end

end
toc


% do nonmaximum suppression in each 2D slice
tic
max_space = zeros(size(scale_space));
sup_window_size = 5;
for i = 1:size(scale_space, 3)
    max_space(:,:,i) = ordfilt2(scale_space(:,:,i), sup_window_size^2, ones(sup_window_size));
    % max_space(:,:,i) = colfilt(scale_space(:,:,i), [sup_window_size sup_window_size], 'sliding', @max);
    % slightly less efficient
end

n = size(scale_space, 3);
for i = 1:n
    max_space(:,:,i) = max(max_space(:,:, max(i-1,1):min(i+1, n)),[],3);
end
max_space = max_space .* (max_space == scale_space);
toc

% set proper threshold
threshold = 0.008;
max_space(max_space<threshold) = 0;

% draw blobs as circles
[blob_x, blob_y, blob_i] = ind2sub(size(max_space),find(max_space > 0));
blob_rad = transpose(sigma(blob_i)) .* 1.4;
figure; show_all_circles(raw, blob_y, blob_x, blob_rad );
