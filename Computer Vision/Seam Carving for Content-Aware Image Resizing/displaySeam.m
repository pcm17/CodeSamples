function displaySeam(im, seam, seamDirection)
%%% Displays the optimal seam to remove from a given image
%%% Arguments:      1. image
%%%                 2. seam path
%%%                 3. seam direction
%%%
%%% Returns:
    if(strcmp(seamDirection, 'VERTICAL'))
        rows = linspace(1,length(seam),length(seam))
        lineSpec = 'yellow';
         % Display image with seem ontop of it
        figure,imshow(im)
        hold on;
        plot(seam,rows, lineSpec);
        hold off;
    else 
        assert(strcmp(seamDirection, 'HORIZONTAL'));
        cols = linspace(1,length(seam),length(seam));
        lineSpec = 'red';
         % Display image with seem ontop of it
        figure, imshow(im)
        hold on;
        plot(cols,seam, lineSpec);
        hold off;
    end
end
    
   