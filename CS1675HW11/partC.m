num_dims = 2;
runs = 1;
Data = load('Data.txt');
for n = 1:runs
% Randomly permute data samples before cross validation split
%data = Data(randperm(size(Data,1)),:);
X = Data(:,1:70);
[X, mapping] = compute_mapping(X, 'PCA', 70);
data = [X Data(:,71)];

numFeats = size(data,2) - 1;
% Randomly permute data features before cross validation split
%X = X(:,randperm(numFeats));
%data(:,1:numFeats) = X;
Y = data(:,numFeats+1);

holdoutCVP = cvpartition(Y,'holdout',round((1/3)*size(Y,1)));

tr_data = data(holdoutCVP.training,:);
tr_x = tr_data(:,1:numFeats);
tr_y= tr_data(:,numFeats+1);

test_data = data(holdoutCVP.test,:);
test_x = test_data(:,1:numFeats);
test_y= test_data(:,numFeats+1);

%[coeff,score_tr,latent_tr] = pca(tr_x);
%[coeff_test,score_test,latent_test,tsquared_test,explained_test,mu_test] = pca(test_x);
%top10eig = latent_tr(1:10);


mu_tr = mean(tr_x);
mu = repmat(mu_tr,size(test_x,1),1);
%test_x = test_x - mu;
mu = repmat(mu_tr,size(tr_x,1),1);
%tr_x = tr_x - mu;

tr_Xtop5 = tr_x*mapping.M(:,1:70);
test_Xtop5 = test_x*mapping.M(:,1:70);

y_pred_pca = classify(test_Xtop5,tr_Xtop5,tr_y,'linear');
err_pca(n,1) = sum(y_pred_pca ~= test_y)/length(y_pred_pca);
C_pca = confusionmat(test_y,y_pred_pca);

[coeff,score,latent_tr] = pca(X);
muX = mean(X);
Xmean = X - repmat(muX,size(X,1),1);
c1 = coeff(1:2,:)';
c2 = coeff(:,1:2);

Xtrans = score*c2;


figure,scatter(Xtrans(Y==0,1),Xtrans(Y==0,2),5,'k')
hold on
scatter(Xtrans(Y==1,1),Xtrans(Y==1,2),5,'r')
title('Scores');
hold off
%}
end

fprintf('\n\nPCA Confusion Matrix:\n');
fprintf('%d\t%d\n',C_pca');
fprintf('PCA error = %.2f\n', mean(err_pca*100));

