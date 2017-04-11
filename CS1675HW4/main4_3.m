
data_train = load('housing_train.txt');
data_test = load('housing_test.txt');

numFeatures = 13;

x_train = data_train(:, 1:numFeatures);
x_train = [x_train ; x_train; x_train];     % Duplicate training data to run more than 1000 steps
y_train = data_train(:, (numFeatures+1));
y_train = [y_train ; y_train; y_train];     % Duplicate training data to run more than 1000 steps

x_test = data_test(:,1:numFeatures);
y_test = data_test(:,(numFeatures+1));


numIters = 300;

% Do you want feature normalization?
normalization = true;

if (normalization)
    x_train = normalize(x_train);       % Normalize input
    x_test = normalize(x_test);         % Normalize input
   
end

x_train = [ones(size(x_train,1),1) x_train];    % Add a col of 1's for the x0 terms
x_test = [ones(size(x_test,1),1) x_test];       % Add a col of 1's for the x0 terms
w = zeros(size(x_train,2),1);                   % Initialize weights to zero
pgraph = init_progress_graph;                   % Initialize graph
 
for iteration = 1:numIters
    w = gradientDescent(x_train, y_train, w, iteration);
    
    if mod(iteration,50) == 0                   % Plot progress
        y_train_pred = x_train*w;
        traine = immse(y_train, y_train_pred);
        y_test_pred = x_test*w;
        teste = immse(y_test, y_test_pred);
        pgraph = add_to_progress_graph(pgraph, iteration, traine, teste);
    end
end

% Make predictions and report MSE for training
y_pred_train = x_train*w;
mse_train = immse(y_train, y_pred_train);
disp(['Training MSE = ' num2str(mse_train)]);

% Make predictions and report MSE for testing
y_pred_test = x_test*w;
mse_test = immse(y_test, y_pred_test);
disp(['Test MSE = ' num2str(mse_test)]);







