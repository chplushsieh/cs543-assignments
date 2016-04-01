function y = homography_transform(x, homography)
xw = transpose([x 1]);

homography = transpose(homography);
yw = homography * xw;

w = yw(3);
yw = yw ./ w;
y = yw(1:2);

y = transpose(y);
end