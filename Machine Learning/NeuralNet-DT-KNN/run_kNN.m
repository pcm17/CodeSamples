%%% kNN classifier for pima
%%% *************************************************************
%%% Milos Hauskrecht
%%% CS1675 Intro to Machine Learning, University of Pittsburgh
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% load the train and test data (both are normalized)
load pima_train.txt;
load pima_test.txt;
tr_data = pima_train;
test_data = pima_test;

data_col= size(tr_data,2)
n_features = data_col - 1

%%% create x
x = tr_data(:,1:n_features);
%% create y vector
y=tr_data(:,data_col);
 
%% builds x for the the test set
x_test = test_data(:,1:n_features);
%% builds y vector for the test set
y_test=test_data(:,data_col);

%%%% classify examples in the test set using the 3NN classifier using the
%%%% Euclidean metric
y_pred=knnclassify(x_test,x,y,3,'euclidean')
error= sum(abs(y_pred-y_test))/size(y_test,1)
accuracy=1-error