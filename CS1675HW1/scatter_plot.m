function [] = scatter_plot( X, Y, attribute_X, attribute_Y )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
figure, scatter(X,Y)
title([attribute_X ' vs ' attribute_Y]);

end

