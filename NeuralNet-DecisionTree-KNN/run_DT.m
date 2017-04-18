%%% learns the decision tree 
%%% *************************************************************
%%% Milos Hauskrecht
%%% 1675 Introduction to Machine Learning, University of Pittsburgh
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% load the train and test data (both are normalized)
load pima_train.txt;
load pima_test.txt;
tr_data = pima_train;
test_data = pima_test;

data_col= size(tr_data,2)
n_features = data_col - 1;

%%% create x
x = tr_data(:,1:n_features);
%% create y vector
y=tr_data(:,data_col);
 
%% builds x for the the test set
x_test = test_data(:,1:n_features);
%% builds y vector for the test set
y_test=test_data(:,data_col);
% 'MaxNumSplits',15,
%%%% new tree with restrictions on the tree size, parent size, and leaf sizes 
%%%% learns a tree with at most 25 splits, such that any parent node 
%%%% has at least 10 examples and any leaf has at least 2 examples

    new_tree=fitctree(x,y, 'NumVariablesToSample',10,'MinParentSize',20,'MinLeafSize',16,'splitcriterion','gdi');
    y_pred=predict(new_tree,x_test);
    error = sum(abs(y_pred-y_test))/size(y_test,1);
    

%plot(leafs,error);
%xlabel('NumVariablesToSample');
%ylabel('Error');
    %%% show the tree logic
%view(new_tree);
%%% show the graphics of the tree
%view(new_tree,'Mode','graph');
%%% evaluate the tree on the test data



