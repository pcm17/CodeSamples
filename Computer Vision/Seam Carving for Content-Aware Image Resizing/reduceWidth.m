function [reducedColorImage,reducedEnergyImage] = reduceWidth(im, energyImage)
    % Determine optimal seam based on cumulative minimu energy map
    M = cumulative_minimum_energy_map(energyImage, 'VERTICAL');
    seam = find_optimal_vertical_seam(M);
    % convert seam indices to seam coordinates to find out which row to
    % delete for each column
    [seamRow, seamColumn] = ind2sub(size(seam), seam);
    
    % Index seamRow
    for n = 1:size(seamRow,1)
        seamRow(n) = n;
    end
    % Loop through rows of the original image and delete the correct column for that row by shifting pixels left one to remove the pixel in the seam
    for i = 1:size(seamRow,1)-2
        % Shift all of the pixels that are to the left of the pixel in
        % the seam right by 1 to remove the seam
        for j = seamColumn(i):1
            im(j,seamRow(j)) = im(j,seamRow(j)+1);
            energyImage(j,seamRow(j)) = energyImage(j,seamRow(j)+1);
        end
    end
    
    % Delete last column of image because we moved every column one pixel
    % to the left
    energyImage(:,size(energyImage,2),:) = [];
    reducedEnergyImage = energyImage;
    im(:,size(im,2),:) = [];
    reducedColorImage = im;
end 
