%%% Experiments with feature ranking using Fischer scores and AUROC
%%% scores
%%% ****************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Machine Learning, University of Pittsburgh 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data = load('Data.txt');
runs = 1;
nTopFeats = 20;
for n = 1:runs
% Randomly permute data before cross validation split
data = Data(randperm(size(Data,1)),:);

numFeats = size(data,2) - 1;
AUROC_scores = zeros(numFeats,2);
Fischer_scores = zeros(numFeats,2);
% Partition data into predictors and classes
X = data(:,1:numFeats);
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

% Calculate AUROC and Fischer scores
for i = 1:numFeats
    AUROC_scores(i,1) = AUROC_score(X(:,i),Y);
    AUROC_scores(i,2) = i;
    Fischer_scores(i,1) = Fischer_score(X(:,i),Y);
    Fischer_scores(i,2) = i;
end

% Display the nTopFeats features with the highest Fischer scores
AUROC_rankings = sortrows(AUROC_scores,-1);
Fischer_rankings = sortrows(Fischer_scores,-1);
[IDX, Z] = rankfeatures(X', Y,'Criterion','roc');
fprintf('\nTop %d Fischer Rankings:\n',nTopFeats);
fprintf('%.4f\t%d\n', Fischer_rankings(1:nTopFeats,:)');

% Determine how many features have Fischer and AUROC scores that 
% are both ranked in the top nTopFeats features
memship = 100*(sum(ismember(AUROC_rankings(1:nTopFeats,2),Fischer_rankings(1:nTopFeats,2)))/nTopFeats);
fprintf('\n%.0f%% of features selected using\nFischer and AUROC ranking are the same\n', memship);
end
