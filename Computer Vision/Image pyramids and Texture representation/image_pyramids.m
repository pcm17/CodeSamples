function image_pyramids()
    % Pyramid function
    function [G, L] = pyramids(im, fil)
        filtered_im = imfilter(im,fil);
        G = im(1:2:end, 1:2:end);
        L = im - filtered_im;
    end

    % Read in image and convert it to grayscale
    im = rgb2gray(imread('seashells.jpg'));
    % Initialize Gaussian & Laplacian Pyramids 
    G = cell(5,1);
    L = cell(5,1);
    % Create gaussian filter
    fil = fspecial('gaussian', 5, 1.0);
    [G{1}, L{1}] = pyramids(im, fil);
    
    % Run to get total of 5 
    for i = 2:5
        [G{i}, L{i}] = pyramids(G{i-1},fil);
        figure, imshow(G{i});
    end
    
    
    
    
end