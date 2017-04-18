function [] = scatter_plot( X, Y, attribute_X, attribute_Y )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
figure, scatter(X,Y);
title([num2str(attribute_X) ' vs ' num2str(attribute_Y)]);

end

