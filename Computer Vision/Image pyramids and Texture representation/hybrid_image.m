% This (I think) does everything that is listed on the assignment but it doesn't
% produce an image that looks like 2 images combined...
im1 = rgb2gray(imresize(imread('woman_happy.png'),[512,512]));
im2 = rgb2gray(imresize(imread('woman_neutral.png'),[512,512]));
filter = fspecial('gaussian', 7, 1.0);

im1_blur = imfilter(im1,filter);
im2_blur = imfilter(im2,filter);
im2_detail = imsubtract(im2, im2_blur);

final_im = imadd(im1_blur, im2_detail);
imwrite(final_im,'Hybrid image.png');
figure, imshow(final_im)
title('FINAL IMAGE')
