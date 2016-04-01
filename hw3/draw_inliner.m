function draw_inliner(img_left, img_right, top_pairs, homography)

[~, r_left, c_left] = compute_num_of_inliners(top_pairs, homography);

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