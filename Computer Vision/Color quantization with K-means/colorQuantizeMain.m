clc;
original_image = imread('fish.jpg');
figure; imshow(original_image);
title('Original Image');
threshold = 0.45;

for k = 2:5
    [outputIm, mean_colors, cluster_ids] = quantizeRGB(original_image, k);
    [error] = computeQuantizationError(original_image, outputIm);
    str = sprintf('Error = %d\tk = %d', error, k);
    disp(str)
end


