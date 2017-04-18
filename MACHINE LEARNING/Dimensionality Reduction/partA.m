Data = load('Data.txt');
runs = 1;
for n = 1:runs
% Randomly permute data before cross validation split
data = Data(randperm(size(Data,1)),:);

numFeats = size(data,2) - 1;
AUROC_scores = zeros(numFeats,2);
Fischer_scores = zeros(numFeats,2);
X = data(:,1:numFeats);
Y = data(:,numFeats+1);

holdoutCVP = cvpartition(Y,'holdout',round((1/3)*size(Y,1)));

tr_data = data(holdoutCVP.training,:);
tr_x = tr_data(:,1:numFeats);
tr_y= tr_data(:,numFeats+1);

test_data = data(holdoutCVP.test,:);
test_x = test_data(:,1:numFeats);
test_y= test_data(:,numFeats+1);

dlmwrite('training_data.txt',tr_data,'delimiter',' ','precision',10);
dlmwrite('test_data.txt',test_data,'delimiter',' ','precision',10);

classf = @(xtrain,ytrain,xtest,ytest) ...
             sum(ytest ~= classify(xtest,xtrain,ytrain,'linear'));
         
%indx_wrap = wrapper_function(tr_data, classf, 'forward');
num_dim = sum(indx_wrap);


% Calculate AUROC and Fischer scores
for i = 1:numFeats
    AUROC_scores(i,1) = AUROC_score(X(:,i),Y);
    AUROC_scores(i,2) = i;
    Fischer_scores(i,1) = Fischer_score(X(:,i),Y);
    Fischer_scores(i,2) = i;
end

AUROC_rankings = sortrows(AUROC_scores,-1);
Fischer_rankings = sortrows(Fischer_scores,-1);
[IDX, Z] = rankfeatures(X', Y,'Criterion','roc');

fprintf('%.4f\t%d\n', Fischer_rankings(1:20,:)');

memship = 100*(sum(ismember(AUROC_rankings(1:20,2),Fischer_rankings(1:20,2)))/20);
fprintf('\n%.2f of features are the same\n', memship);

% Train logistic regression model on top k features selected by AUROC and
% wrapper function where k is set by the number of features selected by the 
% wrapper function.
%{
tr_x_wrap = tr_x(:,indx_wrap);
test_x_wrap = test_x(:,indx_wrap);
y_pred_wrap = classify(test_x_wrap,tr_x_wrap,tr_y,'linear');
err_wrap(n,1) = sum(y_pred_wrap ~= test_y)/length(y_pred_wrap);

indx_AUROC = zeros(1,size(X,2));
dims = AUROC_rankings(1:num_dim,2);
indx_AUROC(dims) = 1;
indx_AUROC = logical(indx_AUROC);

tr_x_AUROC = tr_x(:,indx_AUROC);
test_x_AUROC = test_x(:,indx_AUROC);
y_pred_AUROC = classify(test_x_AUROC,tr_x_AUROC,tr_y,'linear');
err_AUROC(n,1) = sum(y_pred_AUROC ~= test_y)/length(y_pred_AUROC);

y_pred = classify(test_x,tr_x,tr_y,'linear');
err(n,1) = sum(y_pred ~= test_y)/length(y_pred);

find(indx_wrap == 1);
find(indx_AUROC == 1);

fprintf('\n\nAUROC error = %.2f\n', mean(err_AUROC*100));
fprintf('Wrapper error = %.2f\n', mean(err_wrap*100));
fprintf('Regular error = %.2f\n', mean(err*100));
%}
end


function output = wrapper_function(tr_data, classf, direction)

numFeats = size(tr_data,2)-1;
grpTrain = tr_data(:,numFeats+1);
dataTrain = tr_data(:,1:numFeats);

threeFoldCVP = cvpartition(grpTrain,'kfold',3);
output = sequentialfs(classf,dataTrain,grpTrain,...
    'cv',threeFoldCVP,'direction',direction);
end


function score = AUROC_score(x, y)

mdl = fitglm(x,y);
predictions = predict(mdl,x);
[X,Y,T,AUC] = perfcurve(y,predictions,'1');
score = AUC;

end

function score = Fischer_score(x, y)

% Split positive and negative examples
pos_ex = x(y == 1);
neg_ex = x(y == 0);

% Calculate mean
mu_pos = mean(pos_ex);
mu_neg = mean(neg_ex);

sigma_pos = var(pos_ex);
sigma_neg = var(neg_ex);

score = (mu_pos - mu_neg)^2/(sigma_pos + sigma_neg);
end