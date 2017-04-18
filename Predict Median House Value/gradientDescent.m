function [ w ] = gradientDescent( X, y, w, iteration )
% Gradient Descent is used to learn parameters in order to fit a
% straight line to the points.

    m = length(y);              % Number of training examples
    alpha = 2/iteration;        % Recalculate alpha every step

    tempVal = zeros(size(w));  
    temp = (y - X*w);           
    
    for i =1:length(w)
        tempVal(i,1) = sum(temp.*X(:,i));
    end
    
    w = w + (alpha/m)*tempVal;  % Update weights
 
end