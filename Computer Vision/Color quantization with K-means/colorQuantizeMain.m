%%% Experiments with color quantization using k-means clustering
%%% ****************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Computer Vision, University of Pittsburgh 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
original_image = imread('fish.jpg');
figure; imshow(original_image);
title('Original Image');
threshold = 0.45;

for k = 2:5
    [quantizedIm, mean_colors, cluster_ids] = quantizeRGB(original_image, k);
    [error] = computeQuantizationError(original_image, quantizedIm);
    str = sprintf('Error = %d\tk = %d', error, k);
    disp(str)
end

