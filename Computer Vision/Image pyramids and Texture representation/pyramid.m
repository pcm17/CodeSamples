function image_pyramids()
    % Pyramid function
    % This always produces a gaussian image that is 1/2 the size of the
    % corresponding laplacian image.. I could not figure out how to get the
    % gaussian image to be the same size as the corresponding laplacian
    % image.
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
    
    % Display first pyramid images
    figure, imshow(G{1});
    title(['G Pyramid',num2str(1)])
    figure, imshow(L{1});
    title(['L Pyramid',num2str(1)])

    % Run to get total of 5 pyramids
    for i = 2:5
        [G{i}, L{i}] = pyramids(G{i-1},fil);
        figure, imshow(G{i});
        title(['G Pyramid ',num2str(i)])
        figure, imshow(L{i});
        title(['L Pyramid ',num2str(i)])
    end
    for i = 1:5
        imwrite(G{i}, ['G',num2str(i),'.jpg']);
        imwrite(L{i}, ['L',num2str(i),'.jpg']);
    end
end