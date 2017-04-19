 function [reducedColorImage,reducedEnergyImage] = reduceHeight(im, energyImage)
    
    % Determine optimal seam based on cumulative minimu energy map
    M = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');
    seam = find_optimal_horizontal_seam(M);
    % convert seam indices to seam coordinates to find out which row to
    % delete for each column
    [seamRow, seamColumn] = ind2sub(size(seam), seam);

    % Index seamColumn
    for n = 1:size(seamColumn,1)
        seamColumn(n) = n;
    end
    % Loop through columns of the original image and delete the correct row for that column by shifting pixels up one to remove the pixel in the seam
    for j = 1:size(seamColumn,1)-2
        % Shift all of the pixels that are below the pixel in
        % the seam up by 1 to remove the seam
clc
        for i = 2:seamRow(j)
            if seamRow(i) < size(seamRow,1)
                %im(seamRow(i),j) = im(seamRow(i)+1,j);
                %energyImage(seamRow(j),j) = energyImage(seamRow(j)+1,j);
            end
        end
    end
    % Delete last row of image because we moved every row one pixel
    % up
    energyImage(size(energyImage,1),:,:) = [];
    reducedEnergyImage = energyImage;
    im(size(im,1),:,:) = [];
    reducedColorImage = im;
end 

