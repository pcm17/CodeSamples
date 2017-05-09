function displaySeam(im, seam, seamDirection)
%%% Displays the optimal seam to remove from a given image
%%% Arguments:      1. image
%%%                 2. seam path
%%%                 3. seam direction
%%%
%%% Returns:        
    if(strcmp(seamDirection, 'VERTICAL'))
        lineSpec = 'red';
    else 
        assert(strcmp(seamDirection, 'HORIZONTAL'));
       lineSpec = 'blue';
    end
    
    % Display image with seem ontop of it
    imshow(im)
    hold on;
    [x,y] = ind2sub(size(seam), seam);
    plot(seam, lineSpec);
    hold off;
end