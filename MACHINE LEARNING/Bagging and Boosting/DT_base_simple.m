%%% BASE Simple Decision Tree Classifier
%%% learns on the training set, after learning applies the model to the
%%% test set

function [test_y]  = DT_base_simple(tr_x, tr_y, test_x, params)


%% calls decision tree machine code to learn the model
minParentSize = size(tr_x,1);
mdl = fitctree(tr_x, tr_y,'MinParentSize',minParentSize);

%mdl = prune(mdl1,'Level',max(mdl1.PruneList) - 1);
%numLevels2 = max(mdl.PruneList)
%view(mdl,'mode','graph'); % graphic description
%%% now we apply the model to test data and make a decision
test_y=predict(mdl,test_x);

return;