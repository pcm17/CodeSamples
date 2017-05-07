function score = AUROC_score(x, y)
%%% Calculates the area under the ROC curve returns the value
% Arguments:    1. feature vector
%               2. class values
% Returns:  AUROC score for feature vector
mdl = fitglm(x,y);
predictions = predict(mdl,x);
[~,~,~,AUC] = perfcurve(y,predictions,'1');
score = AUC;
end