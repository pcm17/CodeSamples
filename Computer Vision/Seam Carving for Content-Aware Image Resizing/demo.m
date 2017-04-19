im = imread('pittsburgh.png');
energyImage = energy_image(im);

for i = 1:100
    [reducedColorImage,reducedEnergyImage] = reduceHeight(im, energyImage);
end
figure
imshow(reducedEnergyImage);
title('Reduced ENERGY Image');
