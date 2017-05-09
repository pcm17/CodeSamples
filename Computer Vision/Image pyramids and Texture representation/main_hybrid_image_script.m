%%% Experiments with generating hybrid images
%%% ****************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Computer Vision, University of Pittsburgh 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
im1 = rgb2gray(imresize(imread('Hybrid_images/woman_happy.png'),[512,512]));
im2 = rgb2gray(imresize(imread('Hybrid_images/woman_neutral.png'),[512,512]));
hsize = 25;
sigma = 25;
filter = fspecial('gaussian', hsize, sigma);

im1_blur = imfilter(im1,filter);
im2_blur = imfilter(im2,filter);
im2_detail = im2 - im2_blur;

final_im = im1_blur + im2_detail;
imwrite(final_im,'Hybrid_images/Hybrid_image.png');
figure, imshow(final_im)
title('FINAL IMAGE')
