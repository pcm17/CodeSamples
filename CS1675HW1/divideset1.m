function [ data_train, data_test ] = divideset1( data, p_train )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
data_train = [];
data_test = [];
entries = size(data,1);
rand_nums = rand(entries,1);
for i = 1:size(data,1)
    if rand_nums(i) <= p_train
        data_train = [data_train;data(i,:)];
    else
        data_test = [data_test;data(i,:)];
    end  
end

end

