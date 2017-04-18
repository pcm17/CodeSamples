
% Load the training and test data
tr_data = load('hw10_train.txt');
test_data = load('hw10_test.txt');
nFeatures = size(tr_data,2) - 1;
tr_x = tr_data(:,1:nFeatures); tr_y = tr_data(:,nFeatures+1);
test_x = test_data(:,1:nFeatures); test_y = test_data(:,nFeatures+1);

iterations = 80; nModels = 20;
test_acc_boost = zeros(iterations,nModels);
test_acc_bag = zeros(iterations,nModels);
tr_acc_boost = zeros(iterations,nModels);
tr_acc_bag = zeros(iterations,nModels);
test_acc_boost_single = zeros(iterations,nModels);
test_acc_bag_single = zeros(iterations,nModels);

for n=1:nModels
    for i=1:iterations
        params = sprintf('[@SVML_base,%d,[]]', n);
        params_single = sprintf('[@SVML_base,%d,[]]', 1);
        %%% Use bagging to learn 1-10 SVM models from tr_x and tr_y 
        %%% and predict the labels for test_x
        [test_y_boost] = Boost_classifier(tr_x,tr_y,test_x,params);
        [tr_y_boost] = Boost_classifier(tr_x,tr_y,tr_x,params);
        [test_y_boost_single] = Boost_classifier(tr_x,tr_y,test_x,params_single);
        
        [test_y_bag] = Bag_classifier(tr_x,tr_y,test_x,params);
        [tr_y_bag] = Bag_classifier(tr_x,tr_y,tr_x,params);
        [test_y_bag_single] = Bag_classifier(tr_x,tr_y,test_x,params_single);
        
        nCorrect = size(find(test_y_boost == test_y),1);
        test_acc_boost(i,n) = (nCorrect/size(test_data,1))*100;
        
        nCorrect = size(find(tr_y_boost == tr_y),1);
        tr_acc_boost(i,n) = (nCorrect/size(tr_data,1))*100;
        
        nCorrect = size(find(test_y_bag == test_y),1);
        test_acc_bag(i,n) = (nCorrect/size(test_data,1))*100;
        
        nCorrect = size(find(tr_y_bag == tr_y),1);
        tr_acc_bag(i,n) = (nCorrect/size(tr_data,1))*100;
        
        nCorrect = size(find(test_y_boost_single == test_y),1);
        test_acc_boost_single(i,n) = (nCorrect/size(test_data,1))*100;
        
        nCorrect = size(find(test_y_bag_single == test_y),1);
        test_acc_bag_single(i,n) = (nCorrect/size(test_data,1))*100;
    end
end

avg_test_boost = mean(test_acc_boost);
avg_test_bag = mean(test_acc_bag);

avg_tr_boost = mean(tr_acc_boost);
avg_tr_bag = mean(tr_acc_bag);

avg_test_boost_single = mean(test_acc_boost_single);
avg_test_bag_single = mean(test_acc_bag_single);

lowLim = round(min(min(min(avg_test_boost),min(min(avg_tr_boost), min(avg_test_boost_single))),min(min(avg_test_bag),min(min(avg_tr_bag),min(avg_test_bag_single))))) - 1;
highLim = round(max(max(max(avg_test_boost),max(avg_tr_boost)),max(max(avg_test_bag),max(avg_tr_bag)))) + 1;

figure, plot(avg_test_boost,'DisplayName','Test Accuracy');
hold on
plot(avg_tr_boost,'DisplayName','Train Accuracy')
plot(avg_test_boost_single,'DisplayName','Single-Learner Accuracy')
title('Boost SVM Accuracy vs Number of Models'); xlabel('Number of Models'); ylabel('Accuracy'); 
xlim([1 nModels]); ylim([lowLim highLim]);
legend('show')
hold off

figure, plot(avg_test_bag,'DisplayName','Test Accuracy');
hold on
plot(avg_tr_bag,'DisplayName','Train Accuracy')
plot(avg_test_bag_single,'DisplayName','Single-Learner Accuracy')
title('Bag SVM Accuracy vs Number of Models'); xlabel('Number of Models'); ylabel('Accuracy');
xlim([1 nModels]); ylim([lowLim highLim]);
legend('show')
hold off
