function output = wrapper_function(tr_data, classf)

numFeats = size(tr_data,2)-1;
grpTrain = tr_data(:,numFeats+1);
dataTrain = tr_data(:,1:numFeats);

threeFoldCVP = cvpartition(grpTrain,'kfold',3);
output = sequentialfs(classf,dataTrain,grpTrain,...
    'cv',threeFoldCVP);
end