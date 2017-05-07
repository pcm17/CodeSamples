%%% Expirements with Logistic Regression using batch gradient descent
%%% ****************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Machine Learning, University of Pittsburgh 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test_data = load('data/classification_test.txt');
train_data = load('data/classification_train.txt');

X_train = train_data(:,1:2);
X_test = test_data(:,1:2);

y_test = test_data(:,3);
y_train = train_data(:,3);

iterations = 500;                      % Set number of iterations
w = ones(size(X_train,2),1);           % Initialize all weights to 0
pgraph = init_progress_graph;          % Initialize graph

for iteration = 1:iterations
    [ w ] = GLR( X_train, y_train, w, iteration );
   
    if mod(iteration,50) == 0                   % Plot progress
        y_train_pred = sigmoid(X_train*w);
        traine = immse(y_train, y_train_pred);
        y_test_pred = sigmoid(X_test*w);
        teste = immse(y_test, y_test_pred);
        pgraph = add_to_progress_graph(pgraph, iteration, traine, teste);
    end
end

% Make predictions for training data
y_train_pred = round(sigmoid(X_train*w));

% Make predictions for test data
y_test_pred = round(sigmoid(X_test*w));

% Calculate Mean Misclassification Error
mse_train = immse(y_train_pred,y_train);
mse_test = immse(y_test_pred,y_test);

% Generate confusion Matrices
confusion_train = confusionmat(y_train', y_train_pred);
confusion_test = confusionmat(y_test', y_test_pred);
