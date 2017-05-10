%%% Experiments with content aware resizing using seam carving
%%% ****************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Computer Vision, University of Pittsburgh 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

im = imresize(imread('prague.jpg'),1);
energyImage = energy_image(im);
nSeams = 50;
reducedColorImage = im;
reducedEnergyImage = energyImage;
for i = 1:nSeams
    [reducedColorImage,reducedEnergyImage] = reduceHeight(reducedColorImage, reducedEnergyImage);
    [reducedColorImage,reducedEnergyImage] = reduceWidth(reducedColorImage, reducedEnergyImage);
   
    if mod(i,3) == 0
        imshow(reducedColorImage);
    end
end
%%
figure,imshow(reducedColorImage);
title('Final Reduced COLOR Image');
figure,imshow(im);
title('Original COLOR Image');
