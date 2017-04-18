
% Load the training and test data
tr_data = load('hw10_train.txt');
test_data = load('hw10_test.txt');
nFeatures = size(tr_data,2) - 1;
tr_x = tr_data(:,1:nFeatures); tr_y = tr_data(:,nFeatures+1);
test_x = test_data(:,1:nFeatures); test_y = test_data(:,nFeatures+1);

iterations = 10; nModels = 10;
test_acc_boost = zeros(iterations,nModels);
test_acc_bag = zeros(iterations,nModels);

for n=1:nModels
    for i=1:iterations
        params = sprintf('[@SVML_base,%d,[]]', n);
        %%% Use bagging to learn 2-20 SVM model from tr_x and tr_y 
        %%% and predicts the labels for test_x
        [test_y_boost] = Boost_classifier(tr_x,tr_y,test_x,params);
        [test_y_bag] = Bag_classifier(tr_x,tr_y,test_x,params);

        nCorrect = size(find(test_y_boost == test_y),1);
        test_acc_boost(i,n) = (nCorrect/size(test_data,2))*100;
        
        nCorrect = size(find(test_y_bag == test_y),1);
        test_acc_bag(i,n) = (nCorrect/size(test_data,2))*100;
    end
end

avg_test_boost = mean(test_acc_boost);
avg_test_bag = mean(test_acc_bag);

figure, plot(avg_test_boost);
title('Boost Accuracy vs Number of Models'); xlabel('Number of Models'); ylabel('Accuracy'); ylim([83 94]);
figure, plot(avg_test_bag);
title('Bag Accuracy vs Number of Models'); xlabel('Number of Models'); ylabel('Accuracy'); ylim([83 94]);

