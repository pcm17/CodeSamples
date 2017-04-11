function [ x ] = normalize( x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

   mu = zeros(1,size(x,2));
   stddev = zeros(1, size(x,2));
   
   for i = 1:size(mu,2)
       mu(1,i) = mean(x(:,i));
       stddev(1,i) = std(x(:,i));
       x(:,i) = (x(:,i)-mu(1,i))/stddev(1,i);
   end
end

