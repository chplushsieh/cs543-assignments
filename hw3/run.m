% clear everything
close all;
clearvars;

% set saved file path
savedir = './outputs/';
if ~exist(savedir, 'dir')
    mkdir(savedir)
end
savepath = [savedir, 'output', '.png'];

% read and preprocess input images
raw_left = imread('./images/uttower_left.jpg');
raw_right = imread('./images/uttower_right.jpg');

img_left = im2double(rgb2gray(raw_left));
img_right = im2double(rgb2gray(raw_right));

[cim_left, r_left, c_left] = harris(img_left, 3, 0.005, 1, 0);
[cim_right, r_right, c_right] = harris(img_right, 3, 0.005, 1, 0);

neighbor_size = 7;

[r_left, c_left] = remove_near_boundary(r_left, c_left, img_left, neighbor_size);
[r_right, c_right] = remove_near_boundary(r_right, c_right, img_right, neighbor_size);

corner_neighbors_left = get_corner_descriptor(neighbor_size, img_left, r_left, c_left);
corner_neighbors_right = get_corner_descriptor(neighbor_size, img_right, r_right, c_right);

corners_distance = dist2(corner_neighbors_left, corner_neighbors_right);

% Select putative matches. 
% Select the top few hundred descriptor pairs with the smallest pairwise distances.
top_pairs = putative_match(corners_distance, r_left, c_left, r_right, c_right);

% TODO draw top pairs
draw_top_pairs(img_left, top_pairs(:, 1:2));
draw_top_pairs(img_right, top_pairs(:, 3:4));

homography = ransac(top_pairs);

% Solution picked by-hand
% c2 = [577; 886; 983; 706]; % left 
% r2 = [611; 321; 328; 586];
% c1 = [110; 445; 530; 247]; % right
% r1 = [571; 300; 314; 552];
% T = maketform('projective',[c2 r2],[c1 r1]);
% y = homography_transform([577, 611], T.tdata.T);
% display(y)
% >> y = [110, 571]
% draw_inliner(img_left, img_right, top_pairs, T.tdata.T);
% draw_merged_image(img_left, img_right, T);

T = maketform('projective', homography);
T.tdata.T
draw_inliner(img_left, img_right, top_pairs, T.tdata.T);
draw_merged_image(img_left, img_right, T);


