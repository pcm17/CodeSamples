function [ w ] = GLR( X, y, w, k )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

m = size(X,1);
alpha = 2 / k;
w = w + alpha*(1/m)*X'*(y - sigmoid(X*w));


end

