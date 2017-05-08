%%% Experiments with diagnosing pneumonia using Naive Bayes
%%% ****************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Machine Learning, University of Pittsburgh 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  Read in data from the file pneumonia.tex
data = load('data/pneumonia.txt');
num_features = size(data,2) - 1;
num_samples = size(data,1);
X = data(:,1:num_features);
labels = data(:,num_features + 1);

% Separate pneumonia-present data from pneumonia-negative data
pos_samples = find(data(:,num_features+1) == 1);
pos_data = data(pos_samples,:);
neg_samples = find(data(:,num_features+1) == 0);
neg_data = data(neg_samples,:);

%% Calculate ML estimate for pneumonia
p_pneum(1,1) = size(pos_samples,1)/num_samples;
p_pneum(1,2) = 1 - p_pneum(1,1);


%% Calculate ML estimates for fever
% Separate and count samples where pneumonia is present
pos_pneum_data = data(data(:,num_features+1) == 1,:);
pos_pneum_count = size(pos_pneum_data,1);

% Separate and count samples where pneumonia is not present
neg_pneum_data = data(data(:,num_features+1) == 0,:);
neg_pneum_count = size(neg_pneum_data,1);

% Count samples where fever is present, given pneumonia is present
pos_fever_given_pneum_count = size(find(pos_pneum_data(:,1)==1),1);
% Count samples where fever is present, given pneumonia is not present
pos_fever_given_no_pneum_count = size(find(neg_pneum_data(:,1)==1),1);

% Calculate ML estimate of P(fever | pneumonia)
p_fever_given_pneum(1,1) = pos_fever_given_pneum_count/pos_pneum_count;
p_fever_given_pneum(2,1) = 1 - p_fever_given_pneum(1,1);
% Calculate ML estimate of P(fever | no pneumonia)
p_fever_given_pneum(1,2) = pos_fever_given_no_pneum_count/neg_pneum_count;
p_fever_given_pneum(2,2) = 1 - p_fever_given_pneum(1,2);

%% Calculate ML estimates for paleness
% Separate and count samples where pneumonia is present
pos_pneum_data = data(data(:,num_features+1) == 1,:);
pos_pneum_count = size(pos_pneum_data,1);

% Separate and count samples where pneumonia is not present
neg_pneum_data = data(data(:,num_features+1) == 0,:);
neg_pneum_count = size(neg_pneum_data,1);

% Count samples where paleness is present, given pneumonia is present
pos_paleness_given_pneum_count = size(find(pos_pneum_data(:,2)==1),1);
% Count samples where paleness is present, given pneumonia is not present
pos_paleness_given_no_pneum_count = size(find(neg_pneum_data(:,2)==1),1);

% Calculate ML estimate of P(paleness | pneumonia)
p_paleness_given_pneum(1,1) = pos_paleness_given_pneum_count/pos_pneum_count;
p_paleness_given_pneum(2,1) = 1 - p_paleness_given_pneum(1,1);
% Calculate ML estimate of P(paleness | no pneumonia)
p_paleness_given_pneum(1,2) = pos_paleness_given_no_pneum_count/neg_pneum_count;
p_paleness_given_pneum(2,2) = 1 - p_paleness_given_pneum(1,2);

%% Calculate ML estimates for cough
% Separate and count samples where pneumonia is present
pos_pneum_data = data(data(:,num_features+1) == 1,:);
pos_pneum_count = size(pos_pneum_data,1);

% Separate and count samples where pneumonia is not present
neg_pneum_data = data(data(:,num_features+1) == 0,:);
neg_pneum_count = size(neg_pneum_data,1);

% Count samples where cough is present, given pneumonia is present
pos_cough_given_pneum_count = size(find(pos_pneum_data(:,3)==1),1);
% Count samples where cough is present, given pneumonia is not present
pos_cough_given_no_pneum_count = size(find(neg_pneum_data(:,3)==1),1);

% Calculate ML estimate of P(cough | pneumonia)
p_cough_given_pneum(1,1) = pos_cough_given_pneum_count/pos_pneum_count;
p_cough_given_pneum(2,1) = 1 - p_cough_given_pneum(1,1);
% Calculate ML estimate of P(cough | no pneumonia)
p_cough_given_pneum(1,2) = pos_cough_given_no_pneum_count/neg_pneum_count;
p_cough_given_pneum(2,2) = 1 - p_cough_given_pneum(1,2);

%% Calculate ML estimate for High WBC Count
% Separate and count samples where pneumonia is present
pos_pneum_data = data(data(:,num_features+1) == 1,:);
pos_pneum_count = size(pos_pneum_data,1);

% Separate and count samples where pneumonia is not present
neg_pneum_data = data(data(:,num_features+1) == 0,:);
neg_pneum_count = size(neg_pneum_data,1);

% Count samples where highWBC is present, given pneumonia is present
pos_highWBC_given_pneum_count = size(find(pos_pneum_data(:,4)==1),1);
% Count samples where highWBC is present, given pneumonia is not present
pos_highWBC_given_no_pneum_count = size(find(neg_pneum_data(:,4)==1),1);

% Calculate ML estimate of P(highWBC | pneumonia)
p_highWBC_given_pneum(1,1) = pos_highWBC_given_pneum_count/pos_pneum_count;
p_highWBC_given_pneum(2,1) = 1 - p_highWBC_given_pneum(1,1);
% Calculate ML estimate of P(highWBC | no pneumonia)
p_highWBC_given_pneum(1,2) = pos_highWBC_given_no_pneum_count/neg_pneum_count;
p_highWBC_given_pneum(2,2) = 1 - p_highWBC_given_pneum(1,2);

%% Calculate probability of pneumonia given fever and cough, no paleness no high WBC
predict_pneum_1 = p_pneum(1,1)*p_fever_given_pneum(1,1)*p_cough_given_pneum(1,1)*p_highWBC_given_pneum(2,1)*p_paleness_given_pneum(2,1);
predict_pneum_0 = p_pneum(1,2)*p_fever_given_pneum(1,2)*p_cough_given_pneum(1,2)*p_highWBC_given_pneum(2,2)*p_paleness_given_pneum(2,2);
p_pneum_given_fev_cou = predict_pneum_1/(predict_pneum_1+predict_pneum_0);
fprintf('Probability of Pneumonia given Fever and Cough = %.3f\n',p_pneum_given_fev_cou);
%% Calculate probability of pneumonia given fever and cough, missing paleness and HighWBC
predict_pneum_1 = p_pneum(1,1)*p_fever_given_pneum(1,1)*p_cough_given_pneum(1,1)*(p_highWBC_given_pneum(:,1)'*p_paleness_given_pneum(:,1));
predict_pneum_0 = p_pneum(1,2)*p_fever_given_pneum(1,2)*p_cough_given_pneum(1,2)*(p_highWBC_given_pneum(:,2)'*p_paleness_given_pneum(:,2));
p_pneum_given_fev_cou_missing_WBC_pale = predict_pneum_1/(predict_pneum_1 + predict_pneum_0);
fprintf('Probability of Pneumonia given Fever and Cough, missing Palenes and HighWBC = %.3f\n',p_pneum_given_fev_cou_missing_WBC_pale);


