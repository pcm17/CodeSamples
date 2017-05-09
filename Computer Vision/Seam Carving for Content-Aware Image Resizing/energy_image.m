function energyImage = energy_image(im)
%%% Computes the energy image of a given image
%%% Arguments:      1. image
%%%
%%% Returns:        1. computed energy image
    % Convert image from rgb to gray scale
    gray_im = rgb2gray(im);
    % Convert image from datatype u8-int to double
    gray_im = im2double(gray_im);
    s = [1 2 1; 0 0 0; -1 -2 -1];
    % Convolve in both horizontal and vertical directions using filter s
    H = conv2(gray_im,s);
    V = conv2(gray_im,s');
    % Generate energy image
    energyImage = sqrt(H.^2 + V.^2);
end 
