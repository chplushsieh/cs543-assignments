function draw_inliner(img_left, img_right, top_pairs, homography)

[~, inliner_pairs, avg_residual] = count_inliner_part1(top_pairs, homography);
display(avg_residual)

r_left = inliner_pairs(:, 1);
c_left = inliner_pairs(:, 2);

figure, imagesc(img_left), axis image, colormap(gray), hold on
plot(c_left, r_left,'gs'), title('inliners');

r_transformed = zeros(size(r_left));
c_transformed = zeros(size(c_left));
for i=1:size(r_left, 1)
    y = homography_transform([c_left(i), r_left(i)], homography);
    r_transformed(i) = y(2);
    c_transformed(i) = y(1);
end

figure, imagesc(img_right), axis image, colormap(gray), hold on
plot(c_transformed, r_transformed,'gs'), title('transformed inliners');

end