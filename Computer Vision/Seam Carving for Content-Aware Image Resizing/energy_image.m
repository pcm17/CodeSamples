% im is a nrows-x-ncols-x-3 matrix representation of the image

function energyImage = energy_image(im)
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
