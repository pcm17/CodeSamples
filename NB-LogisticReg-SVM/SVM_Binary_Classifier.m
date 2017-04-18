train_data = load('pima_train.txt');
test_data = load('pima_test.txt');
%pgraph = init_progress_graph;                               % Initialize graph
num_attributes = size(train_data,2) - 1; 
num_classes = 2;                                    % number of classes

X_train = train_data(:,1:num_attributes);
X_test = test_data(:,1:num_attributes);

X_train_norm = normalize(X_train);
X_test_norm = normalize(X_test);

y_train = train_data(:,num_attributes+1);
y_test = test_data(:,num_attributes+1);

[W_SVM, b_SVM] = svml(X_train_norm, y_train, 1000);

y_train_pred_SVM = X_train_norm*W_SVM + b_SVM;
y_test_pred_SVM = X_test_norm*W_SVM + b_SVM;

y_test_pred_SVM(y_test_pred_SVM < 0) = 0; y_test_pred_SVM(y_test_pred_SVM > 0) = 1;
y_train_pred_SVM(y_train_pred_SVM < 0) = 0; y_train_pred_SVM(y_train_pred_SVM > 0) = 1; 

traine_SVM = immse(y_train, y_train_pred_SVM);
teste_SVM = immse(y_test, y_test_pred_SVM);

[ confuse_train ] = confusion_matrix( y_train, y_train_pred_SVM, 2 );
[ confuse_test ] = confusion_matrix( y_test, y_test_pred_SVM, 2 );

sens = confuse_test(1,1) / (confuse_test(1,1) + confuse_test(2,1));
spec = confuse_test(2,2) / (confuse_test(2,2) + confuse_test(1,2));

fileId = fopen('p3_results.txt','w');
fprintf(fileId, 'Iterations = 2000\tLearning Rate = 2 / sqrt(i)\n\n');
fprintf(fileId,'Training Misclassification Error = %.4f\nTest Misclassification Error = %.4f\n\n',traine_SVM, teste_SVM);
fprintf(fileId, 'Training Confusion matrix:\n[%d\t%d]\n[%d\t%d]\n\n',confuse_train');
fprintf(fileId, 'Test Confusion matrix:\n[%d\t%d]\n[%d\t%d]\n\n',confuse_test');
fprintf(fileId, 'Sensitivity = %.4f\nSpecificity = %.4f\n\n', sens, spec);


function [ confuse_matrix ] = confusion_matrix( y_true, y_pred, num_classes )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

m = length(y_true);
confuse_matrix = zeros(num_classes,num_classes);            % Initialize and num_classes x num_classes matrix of zeros 

for i = 1:m
    true = y_true(i) + 1;
    predict = y_pred(i) + 1;        % Need +1 because matlab does not use 0 as first index
    confuse_matrix(true,predict) = confuse_matrix(true,predict) + 1;
end

end