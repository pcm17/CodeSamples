function [ data_train, data_test ] = divideset2( data, p_train )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
num_entries = size(data,1);
size_train = round(num_entries*p_train);
new_positions = randperm(size(data,1));
data_rand = zeros(size(data));
for i = 1:num_entries
    data_rand(i,:) = data(new_positions(i),:);
end

data_train = data_rand(1:size_train,:);
data_test = data_rand(size_train:num_entries,:);

