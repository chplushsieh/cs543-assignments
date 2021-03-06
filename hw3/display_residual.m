function display_residual(closest_pt, L, matches, I2, savedir, image_name)
% display points and segments of corresponding epipolar lines

% find endpoints of segment on epipolar line (for display purposes)
pt1 = closest_pt - [L(:,2) -L(:,1)] * 10; % offset from the closest point is 10 pixels
pt2 = closest_pt + [L(:,2) -L(:,1)] * 10;

c = figure; clf; imshow(I2); hold on;
plot(matches(:,3), matches(:,4), '+r');
line([matches(:,3) closest_pt(:,1)]', [matches(:,4) closest_pt(:,2)]', 'Color', 'r');
line([pt1(:,1) pt2(:,1)]', [pt1(:,2) pt2(:,2)]', 'Color', 'g');

saveas(c, [savedir image_name '_result.png'],'png');


% compute and display residual
avg_residual = 0;

for i = 1:size(closest_pt, 1)
    right_coordinate = matches(i, 3:4);
    left_transormed = closest_pt(i, 1:2);

    error_distance = dist2(left_transormed, right_coordinate);
    avg_residual = avg_residual + error_distance;
end
 
avg_residual = avg_residual / size(closest_pt, 1);
display(avg_residual)

end