%%% Experiments with pneumonia diagnosis using Naive Bayes inference
%%% ****************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Machine Learning, University of Pittsburgh 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read in data from text file
data = load('data/example.txt');
num_features = size(data,2);
num_samples = size(data,1);
% Run learning script to ensure class conditional probabilities are
% calculated
learning

% Loop through all samples and choose the class conditional probability for
% each symptom/feature (fever,cough,etc.) based on whether that symptom is present in the sample. 
for i = 1:num_samples
    sample = data(i,:);
    if sample(1) == 1
        p_fever_given_pneum1 = p_fever_given_pneum(1,1);
        p_fever_given_pneum0 = p_fever_given_pneum(1,2);
    elseif sample(1) == 0
        p_fever_given_pneum1 = p_fever_given_pneum(2,1);
        p_fever_given_pneum0 = p_fever_given_pneum(2,2);
    else
        p_fever_given_pneum1 = p_fever_given_pneum(:,1);
        p_fever_given_pneum0 = p_fever_given_pneum(:,2);
    end
    if sample(2) == 1
        p_paleness_given_pneum1 = p_paleness_given_pneum(1,1);
        p_paleness_given_pneum0 = p_paleness_given_pneum(1,2);
    elseif sample(2) == 0
        p_paleness_given_pneum1 = p_paleness_given_pneum(2,1);
        p_paleness_given_pneum0 = p_paleness_given_pneum(2,2);
    else
        p_paleness_given_pneum1 = p_paleness_given_pneum(:,1);
        p_paleness_given_pneum0 = p_paleness_given_pneum(:,2);
    end
    if sample(3) == 1
        p_cough_given_pneum1 = p_cough_given_pneum(1,1);
        p_cough_given_pneum0 = p_cough_given_pneum(1,2);
    elseif sample(3) == 0
        p_cough_given_pneum1 = p_cough_given_pneum(2,1);
        p_cough_given_pneum0 = p_cough_given_pneum(2,2);
    else
        p_cough_given_pneum1 = p_cough_given_pneum(:,1);
        p_cough_given_pneum0 = p_cough_given_pneum(:,2);
    end
    if sample(4) == 1
        p_highWBC_given_pneum1 = p_highWBC_given_pneum(1,1);
        p_highWBC_given_pneum0 = p_highWBC_given_pneum(1,2);
    elseif sample(4) == 0
        p_highWBC_given_pneum1 = p_highWBC_given_pneum(2,1);
        p_highWBC_given_pneum0 = p_highWBC_given_pneum(2,2);
    else
        p_highWBC_given_pneum1 = p_highWBC_given_pneum(:,1);
        p_highWBC_given_pneum0 = p_highWBC_given_pneum(:,2);
    end
    predict_pneum1 = p_pneum(1,1)*p_fever_given_pneum1*p_paleness_given_pneum1*p_cough_given_pneum1*p_highWBC_given_pneum1;
    predict_pneum0 = p_pneum(1,2)*p_fever_given_pneum0*p_paleness_given_pneum0*p_cough_given_pneum0*p_highWBC_given_pneum0;
    if size(predict_pneum1,1) ~= 1
        predict_pneum1 = sum(predict_pneum1);
        predict_pneum0 = sum(predict_pneum0);
    end
    p_pneum_infer(i,1) = predict_pneum1/(predict_pneum1+predict_pneum0);
        
end