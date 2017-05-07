function [ w ] = GLR( X, y, w, k )
% Update weight vector
%   This function uses the gradient of the error function and alpha to
%   update the weight vector 
m = size(X,1);
alpha = 2 / k;
w = w + alpha*(1/m)*X'*(y - sigmoid(X*w));
end

