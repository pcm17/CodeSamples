function [error] = computeQuantizationError(origImg, quantizedImg)
%%% Computes the error signal between the original image and quantized
%%% image.
%%% Arguments:      1. original image
%%%                 2. quantized image
%%%
%%% Returns:        1. error value
    X = origImg - quantizedImg;
    error = sum(X(:).^2);
end