function draw_merged_image(img_left, img_right, T, savedir)

% draw merged image
im2 = img_left;
im1 = img_right;

[im2t,xdataim2t,ydataim2t]=imtransform(im2,T);
% now xdataim2t and ydataim2t store the bounds of the transformed im2
xdataout=[min(1,xdataim2t(1)) max(size(im1,2),xdataim2t(2))];
ydataout=[min(1,ydataim2t(1)) max(size(im1,1),ydataim2t(2))];
% let's transform both images with the computed xdata and ydata
im2t=imtransform(im2,T,'XData',xdataout,'YData',ydataout);
im1t=imtransform(im1,maketform('affine',eye(3)),'XData',xdataout,'YData',ydataout);

ims=im1t/2+im2t/2;
c = figure, imshow(ims);
saveas(c, [savedir 'merged.png'],'png');
end