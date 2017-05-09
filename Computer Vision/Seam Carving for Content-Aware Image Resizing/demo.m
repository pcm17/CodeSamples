%%% Experiments with content aware resizing using seam carving
%%% ****************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Computer Vision, University of Pittsburgh 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

im = imread('pittsburgh.png');
energyImage = energy_image(im);
[reducedColorImage,reducedEnergyImage] = reduceHeight(im, energyImage);
%[reducedColorImage,reducedEnergyImage] = reduceWidth(im, energyImage);
nSeams = 15;
for i = 1:nSeams
    i
    %[reducedColorImage,reducedEnergyImage] = reduceHeight(reducedColorImage, reducedEnergyImage);
    [reducedColorImage,reducedEnergyImage] = reduceWidth(reducedColorImage, reducedEnergyImage);
end

figure,imshow(reducedColorImage);
title('Reduced COLOR Image');

figure,imshow(im);
title('Original COLOR Image');
