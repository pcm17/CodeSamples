function [ normalized_data ] = normalize( unnormalized_data )
% Normalizes the values in a vector and returns a vector with the
% normalized values

mu = mean(unnormalized_data);
sigma = std(unnormalized_data);
normalized_data = zeros(size(unnormalized_data));

for i = 1:size(unnormalized_data)
    normalized_data(i) = (unnormalized_data(i) - mu)/sigma;
end

