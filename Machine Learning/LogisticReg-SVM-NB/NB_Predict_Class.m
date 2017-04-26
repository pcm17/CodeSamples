%%% Experiments with Naive Bayes classifier for diabetes classification
%%% *************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Machine Learning, University of Pittsburgh
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y_train_pred_NB = predict_NB(X_train, exp_0_1_mu, exp_1_1_mu, norm_0_2_mu, norm_0_2_sigma, norm_1_2_mu, norm_1_2_sigma, norm_0_3_mu, norm_0_3_sigma,norm_1_3_mu, norm_1_3_sigma, norm_0_4_mu, norm_0_4_sigma, norm_1_4_mu, norm_1_4_sigma, exp_0_5_mu, exp_1_5_mu, norm_0_6_mu, norm_0_6_sigma, norm_1_6_mu, norm_1_6_sigma,exp_0_7_mu, exp_1_7_mu, exp_0_8_mu, exp_1_8_mu, prior_y0, prior_y1);
y_test_pred_NB = predict_NB(X_test, exp_0_1_mu, exp_1_1_mu, norm_0_2_mu, norm_0_2_sigma, norm_1_2_mu, norm_1_2_sigma, norm_0_3_mu, norm_0_3_sigma,norm_1_3_mu, norm_1_3_sigma, norm_0_4_mu, norm_0_4_sigma, norm_1_4_mu, norm_1_4_sigma, exp_0_5_mu, exp_1_5_mu, norm_0_6_mu, norm_0_6_sigma, norm_1_6_mu, norm_1_6_sigma,exp_0_7_mu, exp_1_7_mu, exp_0_8_mu, exp_1_8_mu, prior_y0, prior_y1);

% Calculate Mean Misclassification Error
traine_NB = immse(y_train_pred_NB,y_train);
teste_NB = immse(y_test_pred_NB,y_test);

confuse_train = confusion_matrix(y_train, y_train_pred_NB, 2);
confuse_test = confusion_matrix(y_test, y_test_pred_NB, 2);

sens = confuse_test(1,1) / (confuse_test(1,1) + confuse_test(2,1));
spec = confuse_test(2,2) / (confuse_test(2,2) + confuse_test(1,2));

fileId = fopen('p2_results.txt','w');
fprintf(fileId,'Training Misclassification Error = %.4f\nTest Misclassification Error = %.4f\n\n',traine_NB, teste_NB);
fprintf(fileId, 'Training Confusion matrix:\n[%d\t%d]\n[%d\t%d]\n\n',confuse_train');
fprintf(fileId, 'Test Confusion matrix:\n[%d\t%d]\n[%d\t%d]\n\n',confuse_test');
fprintf(fileId, 'Sensitivity = %.4f\nSpecificity = %.4f\n\n', sens, spec);

function [y_pred] = predict_NB(X, exp_0_1_mu, exp_1_1_mu, norm_0_2_mu, norm_0_2_sigma, norm_1_2_mu, norm_1_2_sigma, norm_0_3_mu, norm_0_3_sigma,norm_1_3_mu, norm_1_3_sigma, norm_0_4_mu, norm_0_4_sigma, norm_1_4_mu, norm_1_4_sigma, exp_0_5_mu, exp_1_5_mu, norm_0_6_mu, norm_0_6_sigma, norm_1_6_mu, norm_1_6_sigma,exp_0_7_mu, exp_1_7_mu, exp_0_8_mu, exp_1_8_mu, prior_y0, prior_y1)
% Makes class prediction based on model parameters

pd10 = exppdf(X(:,1),exp_0_1_mu); 
pd11 = exppdf(X(:,1),exp_1_1_mu); 

pd20 = normpdf(X(:,2),norm_0_2_mu, norm_0_2_sigma); 
pd21 = normpdf(X(:,2),norm_1_2_mu, norm_1_2_sigma);

pd30 = normpdf(X(:,3),norm_0_3_mu, norm_0_3_sigma); 
pd31 = normpdf(X(:,3),norm_1_3_mu, norm_1_3_sigma);

pd40 = normpdf(X(:,4),norm_0_4_mu, norm_0_4_sigma); 
pd41 = normpdf(X(:,4),norm_1_4_mu, norm_1_4_sigma);

pd50 = exppdf(X(:,5),exp_0_5_mu); 
pd51 = exppdf(X(:,5),exp_1_5_mu); 

pd60 = normpdf(X(:,6),norm_0_6_mu, norm_0_6_sigma); 
pd61 = normpdf(X(:,6),norm_1_6_mu, norm_1_6_sigma);

pd70 = exppdf(X(:,7),exp_0_7_mu); 
pd71 = exppdf(X(:,7),exp_1_7_mu); 

pd80 = exppdf(X(:,8),exp_0_8_mu); 
pd81 = exppdf(X(:,8),exp_1_8_mu); 

y_pred = zeros(size(X,1),1);     % Initialize prediction array

for i = 1:size(X,1)
    prob0 = log(pd10(i))+log(pd20(i))+log(pd30(i))+log(pd40(i))+log(pd50(i))+log(pd60(i))+log(pd70(i))+log(pd80(i)) + log(prior_y0);
    prob1 = log(pd11(i))+log(pd21(i))+log(pd31(i))+log(pd41(i))+log(pd51(i))+log(pd61(i))+log(pd71(i))+log(pd81(i)) + log(prior_y1);
    %norm_term = prob0 + prob1;
    
    if prob1 > prob0
        y_pred(i,1) = 1;
    end
end

end

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