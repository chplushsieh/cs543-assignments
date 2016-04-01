function draw_top_pairs(img, xy)

r = xy(:, 1);
c = xy(:, 2);

figure, imagesc(img), axis image, colormap(gray), hold on
plot(c,r,'rs'), title('top pairs detected');

end