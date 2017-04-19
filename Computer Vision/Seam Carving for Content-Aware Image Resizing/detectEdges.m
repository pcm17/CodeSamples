function [edges] = detectEdges(im, threshold)
    im = im2double(im);
    [dx,dy] = meshgrid(-1:1,-1:1);
    Ix = conv2(dx,rgb2gray(im));
    Iy = conv2(dy,rgb2gray(im));
    i = 1;
    num_rows = size(im, 1);
    num_cols = size(im, 2);
    edges = zeros(num_rows*num_cols, 4);
    edge_image = zeros(num_rows,num_cols);
    for x = 1:num_rows 
        for y = 1:num_cols 
            % Calculate gradient magnitude at pixel
            gradient_magnitude =  sqrt(Ix(x, y)^2 + Iy(x, y)^2); 
            % Calculate the orientation of the gradient
            gradient_orientation = atand(Iy(x, y) / Ix(x, y));
            if gradient_magnitude > threshold
                edges(i,1) = x;
                edges(i,2) = y;
                edges(i,3) = gradient_magnitude;
                edges(i,4) = gradient_orientation;
                edge_image(x,y) = gradient_magnitude;
                i = i + 1;
            end
        end
    end
    imwrite(edge_image, 'EDGE_IMAGE.jpg')
    imshow(edge_image)
    title('Edge Image')
    
end