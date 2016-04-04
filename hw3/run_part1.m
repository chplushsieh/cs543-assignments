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

top_pairs = get_top_pairs(img_left, img_right);

draw_top_pairs(img_left, top_pairs(:, 1:2));
draw_top_pairs(img_right, top_pairs(:, 3:4));

homography = ransac(top_pairs);

% % Solution picked by-hand
% c2 = [577; 886; 983; 706]; % left 
% r2 = [611; 321; 328; 586];
% c1 = [110; 445; 530; 247]; % right
% r1 = [571; 300; 314; 552];
% T = maketform('projective',[c2 r2],[c1 r1]);
% y = homography_transform([577, 611], T.tdata.T);
% display(y)
% % >> y = [110, 571]
% draw_inliner(img_left, img_right, top_pairs, T.tdata.T);
% draw_merged_image(img_left, img_right, T);

draw_inliner(img_left, img_right, top_pairs, homography);

T = maketform('projective', homography);
draw_merged_image(img_left, img_right, T);