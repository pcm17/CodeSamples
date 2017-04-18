test_data = load('classification_test.txt');
train_data = load('classification_train.txt');


X_train = train_data(:,1:2);
X_test = test_data(:,1:2);

y_train = train_data(:,3);
y_test = test_data(:,3);

% Calculate ML estimates of parameters
[u0, u1, covar] = Max_Likelihood(train_data);

% Make predictions for training and test data
[ y_train_pred ] = Predict_class( train_data, u0, u1, covar );
[ y_test_pred ] = Predict_class( test_data, u0, u1, covar );

% Calculate Mean Misclassification Error
mse_train = immse(y_train_pred,y_train)
mse_test = immse(y_test_pred,y_test)

% Generate confusion Matrices
confusion_train = confusionmat(y_train', y_train_pred)
confusion_test = confusionmat(y_test', y_test_pred)


