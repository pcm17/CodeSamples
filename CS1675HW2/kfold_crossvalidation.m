function [ train, test ] = kfold_crossvalidation( data, k, m )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
indices = crossvalind('Kfold', data, k);
%test = zeros(round(size(data,1)/k),1);
test_count = 1;
train_count = 1;
for i = 1:size(data,1)
    if indices(i) == m
        test(test_count) = data(i);
        test_count=test_count+1;
    else
        train(train_count) = data(i);
        train_count = train_count+1;
    end
end

end

