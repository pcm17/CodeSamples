function displaySeam(im, seam, seamDirection)
    % im is the result of an imread
    % seam should be the output of find_optimal_vertical_seam or find_optimal_horizontal_seam.
    % seamDirection should be the strings 'HORIZONTAL' or 'VERTICAL'
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