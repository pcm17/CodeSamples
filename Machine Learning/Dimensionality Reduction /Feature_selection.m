%%% Experiments with dimensionality reduction using Fischer score, AUROC
%%% score, and wrapper methods
%%% ****************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Machine Learning, University of Pittsburgh 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data = load('Data.txt');
runs = 1;
for n = 1:runs
% Randomly permute data before cross validation split
data = Data(randperm(size(Data,1)),:);

numFeats = size(data,2) - 1;
AUROC_scores = zeros(numFeats,2);
Fischer_scores = zeros(numFeats,2);
indx_AUROC = zeros(1,numFeats);
indx_Fischer = zeros(1,numFeats);

% Partition data into predictors and classes
X = data(:,1:numFeats);
%X = X(:,randperm(size(X,2)));
Y = data(:,numFeats+1);

% Partition data into training and test sets using holdout method
holdoutCVP = cvpartition(Y,'holdout',round((1/3)*size(Y,1)));

% Training data
tr_data = data(holdoutCVP.training,:);
tr_x = tr_data(:,1:numFeats);   tr_y= tr_data(:,numFeats+1);
% Test data
test_data = data(holdoutCVP.test,:);
test_x = test_data(:,1:numFeats);   test_y= test_data(:,numFeats+1);

% Write training and test data out to separate files
dlmwrite('training_data.txt',tr_data,'delimiter',' ','precision',10);
dlmwrite('test_data.txt',test_data,'delimiter',' ','precision',10);

classf = @(xtrain,ytrain,xtest,ytest) ...
             sum(ytest ~= classify(xtest,xtrain,ytrain,'linear'));

% Determine indices to keep using the wrapper method          
indx_wrap = wrapper_function(tr_data, classf);
num_dim = sum(indx_wrap);


%% Calculate AUROC and Fischer scores
for i = 1:numFeats
    AUROC_scores(i,1) = AUROC_score(X(:,i),Y);
    AUROC_scores(i,2) = i;
    Fischer_scores(i,1) = Fischer_score(X(:,i),Y);
    Fischer_scores(i,2) = i;
end

AUROC_rankings = sortrows(AUROC_scores,-1);
Fischer_rankings = sortrows(Fischer_scores,-1);

%% Train logistic regression model on top k features selected by AUROC and
% wrapper function where k is set by the number of features selected by the 
% wrapper function.

tr_x_wrap = tr_x(:,indx_wrap);
test_x_wrap = test_x(:,indx_wrap);
y_pred_wrap = classify(test_x_wrap,tr_x_wrap,tr_y,'linear');
err_wrap(n,1) = sum(y_pred_wrap ~= test_y)/length(y_pred_wrap);

%% Fischer Error
dims = Fischer_rankings(1:num_dim,2);
indx_Fischer(dims) = 1;
indx_Fischer = logical(indx_Fischer);

tr_x_Fischer = tr_x(:,indx_Fischer);
test_x_Fischer = test_x(:,indx_Fischer);
y_pred_Fischer = classify(test_x_Fischer,tr_x_Fischer,tr_y,'linear');
err_Fischer(n,1) = sum(y_pred_Fischer ~= test_y)/length(y_pred_Fischer);

%% AUROC Error
dims = AUROC_rankings(1:num_dim,2);
indx_AUROC(dims) = 1;
indx_AUROC = logical(indx_AUROC);

tr_x_AUROC = tr_x(:,indx_AUROC);
test_x_AUROC = test_x(:,indx_AUROC);
y_pred_AUROC = classify(test_x_AUROC,tr_x_AUROC,tr_y,'linear');
err_AUROC(n,1) = sum(y_pred_AUROC ~= test_y)/length(y_pred_AUROC);

%% Normal Error
y_pred = classify(test_x,tr_x,tr_y,'linear');
err(n,1) = sum(y_pred ~= test_y)/length(y_pred);

end

%% Confusion Matrices and Errors
C_AUROC = confusionmat(test_y,y_pred_AUROC);
C_wrap = confusionmat(test_y,y_pred_wrap);
C_Fischer = confusionmat(test_y,y_pred_Fischer);
C_reg = confusionmat(test_y,y_pred);

fprintf('\n\nAUROC Conf:\n');
fprintf('%d\t%d\n',C_AUROC);
fprintf('AUROC error = %.2f\n', mean(err_AUROC*100));

fprintf('\n\nFisher Conf:\n');
fprintf('%d\t%d\n',C_Fischer);
fprintf('Fischer error = %.2f\n', mean(err_Fischer*100));

fprintf('\n\nWrapper Conf:\n');
fprintf('%d\t%d\n',C_wrap);
fprintf('Wrapper error = %.2f\n', mean(err_wrap*100));

fprintf('\n\nRegular Conf:\n');
fprintf('%d\t%d\n',C_reg);
fprintf('Regular error = %.2f\n', mean(err*100));
