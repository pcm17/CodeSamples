 test_data = load('classification_test.txt');
train_data = load('classification_train.txt');


X_train = train_data(:,1:2);
X_train = [X_train; X_train];
X_test = test_data(:,1:2);

y_test = test_data(:,3);
y_train = train_data(:,3);
y_train = [y_train;y_train];

m = length(y_train);                    % Number of training examples
iterations = 500;
pgraph = init_progress_graph;           % Initialize graph
%X_train = [ones(m,1) X_train];          % Add a column of ones to X_train
%X_test = [ones(length(y_test),1) X_test];      % Add a column of ones to X_train

n = size(X_train,2);                % Number of features
W = ones(size(X_train,2),1);


% Online Gradient Descent
for iteration = 1:iterations
    
    W = Log_regression(X_train, y_train, W, iteration);
    
    
    
    if mod(iteration,50) == 0                   % Plot progress
        y_train_pred = sigmoid(X_train*W);
        traine = immse(y_train, y_train_pred);
        y_test_pred = sigmoid(X_test*W);
        teste = immse(y_test, y_test_pred);
        pgraph = add_to_progress_graph(pgraph, iteration, traine, teste);
    end
 
end

% Make predictions for training data
y_train_pred = round(sigmoid(X_train*W));



% Make predictions for test data
y_test_pred = round(sigmoid(X_test*W));


% Generate confusion Matrices
confusion_train = confusionmat(y_train', y_train_pred)
confusion_test = confusionmat(y_test', y_test_pred)

% Calculate Mean Misclassification Error

mse_train = immse(y_train_pred,y_train);
mse_test = immse(y_test_pred,y_test);

mean_train_error = sum(abs(y_train-round(y_train_pred)))/size(y_train_pred,1)
mean_test_error = sum(abs(y_test-round(y_test_pred)))/size(y_test_pred,1)

function W = Log_regression(X, Y, W, k)

    sum_err = 0;                    %%% initialize batch error function gradient
    for row = 1:1:size(X, 1)
        x = X(row,:)';
        y = Y(row,:);
        f = 1/(1 + exp(-(W'*x)));
        err = (y - f) * x;          % error (on-line gradient)
        sum_err = sum_err + err;    % update batch error function gradient
    end
    alpha = 2/k;
    W = W + (alpha * sum_err);
end
