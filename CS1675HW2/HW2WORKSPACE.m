data = load('mean-study-data.txt');
mean_value = mean(data);
standard_deviation = std(data);
size = 25;

for n = 1:2
    means = zeros(1000,1);
    for i = 1:1000
        new_data = subsample(data, size);
        means(i) = mean(new_data);
    end

    figure, hist(means,20);
    title([size]);
    size = 40;
end
figure, hist(data, 20);
title('Data distribution');
%}\

data = load('resampling-data.txt');
k = 10;
runs = 100;
test_fold_index = [1,2,3,4,5,6,7,8,9,10];
n = 1;
means=zeros(runs,1);
stds=zeros(runs,1);
for i = 1:runs
    [train, test] = kfold_crossvalidation(data, k, test_fold_index(n));
    means(i) = mean(test);
    stds(i) = std(test);
    if n == 10
        n = 0;
    end
    n=n+1;
end

figure,hist(means,20);
title('Means');
figure,hist(stds,20);
title('Standard Deviations');
