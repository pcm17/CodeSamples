function score = Fischer_score(x, y)
%%% Calculates the Fischer score for each feature and returns the value
% Arguments:    1. feature vector
%               2. class values
% Returns:  fischer score for feature vector
% Split positive and negative examples
pos_ex = x(y == 1);
neg_ex = x(y == 0);

% Calculate mean for each
mu_pos = mean(pos_ex);
mu_neg = mean(neg_ex);

% Calculate variance for each
sigma_pos = var(pos_ex);
sigma_neg = var(neg_ex);

% Calculate Fischer score
score = (mu_pos - mu_neg)^2/(sigma_pos + sigma_neg);
end