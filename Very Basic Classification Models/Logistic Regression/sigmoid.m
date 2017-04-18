function [ new_z ] = sigmoid( z )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
new_z = zeros(size(z));
for i = 1:size(z,1)
    new_z(i) = 1/(1+exp(-z(i)));
end
end

