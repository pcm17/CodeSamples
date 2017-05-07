function IDX = wrapper_function(data, classf)
%%% Wrapper method to reduce the dimensionality of a data set
% Arguments:    1. data set
%               2. classification function
% Returns:  indices of features to keep
numFeats = size(data,2)-1;
Y = data(:,numFeats+1);
X = data(:,1:numFeats);

threeFoldCVP = cvpartition(Y,'kfold',3);
IDX = sequentialfs(classf,X,Y,'cv',threeFoldCVP);
end