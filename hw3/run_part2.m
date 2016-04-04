% clear everything
close all;
clearvars;

is_normalized = 1;
is_putative_match = 0; % set to 0 to use ground truth matches

%%
%% load images and match files for the first example
%%

I1 = imread('./assignment3_part2_data/house1.jpg');
I2 = imread('./assignment3_part2_data/house2.jpg');

matches = load('./assignment3_part2_data/house_matches.txt'); 
% this is a N x 4 file where the first two numbers of each row
% are coordinates of corners in the first image and the last two
% are coordinates of corresponding corners in the second image: 
% matches(i,1:2) is a point in the first image
% matches(i,3:4) is a corresponding point in the second image

N = size(matches,1);

%%
%% display two images side-by-side with matches
%% this code is to help you visualize the matches, you don't need
%% to use it to produce the results for the assignment
%%
figure; imshow([I1 I2]); hold on;
plot(matches(:,1), matches(:,2), '+r');
plot(matches(:,3)+size(I1,2), matches(:,4), '+r');
line([matches(:,1) matches(:,3) + size(I1,2)]', matches(:,[2 4])', 'Color', 'r');
% pause;

%%
%% display second image with epipolar lines reprojected 
%% from the first image
%%

if is_putative_match
    img_left = im2double(rgb2gray(I1));
    img_right = im2double(rgb2gray(I2));
    top_pairs = get_top_pairs(img_left, img_right);
    % draw_top_pairs(img_left, top_pairs(:, 1:2));
    % draw_top_pairs(img_right, top_pairs(:, 3:4));
    
    homography = ransac(top_pairs);
    draw_inliner(img_left, img_right, top_pairs, homography);
    
    % T = maketform('projective', homography);
    % draw_merged_image(img_left, img_right, T);
    
    [num_of_inliner, inliner_pairs] = compute_num_of_inliners(top_pairs, homography);
    matches_for_F = inliner_pairs;
else
    matches_for_F = matches;
end

% first, fit fundamental matrix to the matches
F = fit_fundamental(matches_for_F, is_normalized); % this is a function that you should write
L = (F * [matches(:,1:2) ones(N,1)]')'; % transform points from 
% the first image to get epipolar lines in the second image

% find points on epipolar lines L closest to matches(:,3:4)
L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3); % rescale the line
pt_line_dist = sum(L .* [matches(:,3:4) ones(N,1)],2);
closest_pt = matches(:,3:4) - L(:,1:2) .* repmat(pt_line_dist, 1, 2);

% find endpoints of segment on epipolar line (for display purposes)
pt1 = closest_pt - [L(:,2) -L(:,1)] * 10; % offset from the closest point is 10 pixels
pt2 = closest_pt + [L(:,2) -L(:,1)] * 10;

% display points and segments of corresponding epipolar lines
figure; 
clf;
imshow(I2); hold on;
plot(matches(:,3), matches(:,4), '+r');
line([matches(:,3) closest_pt(:,1)]', [matches(:,4) closest_pt(:,2)]', 'Color', 'r');
line([pt1(:,1) pt2(:,1)]', [pt1(:,2) pt2(:,2)]', 'Color', 'g');

%%
%% Display the two camera centers and reconstructed points in 3D
%% 

P1 = load('./assignment3_part2_data/house1_camera.txt');
P2 = load('./assignment3_part2_data/house2_camera.txt');

x1 = transpose(matches(:, 1:2));
x2 = transpose(matches(:, 3:4));
x_world = triangulate(x1, x2, P1, P2);

figure; axis equal; hold on;
plot3(x_world(2, :), x_world(1, :), x_world(3, :), 'o');

R1 = P1(:, 1:3);
R2 = P2(:, 1:3);

t1 = P1(:, 4);
t2 = P2(:, 4);

center1 = -inv(R1) * t1;
center2 = -inv(R2) * t2;
plot3(center1(2), center1(1), center1(3), 'rx');
plot3(center2(2), center2(1), center2(3), 'gx');
