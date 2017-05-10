 function [reducedColorImage,reducedEnergyImage] = reduceHeight(im, energyImage)
%%% Reduces the height of an image and it's energy image by carving seams
%%% through the lowest energy, horizontal path
%%% image "lands" in the second image
%%% Arguments:      1. image
%%%                 2. energy image
%%%
%%% Returns:        1. reduced color image
%%%                 2. reduced energy image 
    reducedColorImage = im;
    % Determine optimal seam based on cumulative minimu energy map
    M = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');
    seam = find_optimal_horizontal_seam(M);
    col = reducedColorImage(:,1,:);
    col(seam(1),:,:) = [];
    newI = col;
    for s = 2:length(seam)
        col = reducedColorImage(:,s,:);
        col(seam(s),:,:) = [];
        newI= [newI, col];
    end
    reducedColorImage = newI;
    reducedEnergyImage = energy_image(reducedColorImage);
end 

