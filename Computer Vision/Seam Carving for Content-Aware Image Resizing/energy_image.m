function Gmag = energy_image(im)
%%% Computes the energy image of a given image
%%% Arguments:      1. image
%%%
%%% Returns:        1. computed energy image
    % Convert image from rgb to gray scale
    gray_im = rgb2gray(im);
    % Convert image from datatype u8-int to double
    gray_im = im2double(gray_im);
     [Gx, Gy] = imgradientxy(gray_im);
    [Gmag, Gdir] = imgradient(Gx, Gy);
    %figure, imshow(Gmag, []), title('Gradient magnitude')
    %figure, imshow(Gdir, []), title('Gradient direction')
    %figure, imshow(Gx, []), title('Directional gradient: X axis')
    %figure, imshow(Gy, []), title('Directional gradient: Y axis')
end 
