function [error] = computeQuantizationError(origImg, quantizedImg)
    X = origImg - quantizedImg;
    error = sum(X(:).^2);
end