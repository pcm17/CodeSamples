function score = Fischer_score(x, y)
% Split positive and negative examples
pos_ex = x(y == 1);
neg_ex = x(y == 0);

% Calculate mean
mu_pos = mean(pos_ex);
mu_neg = mean(neg_ex);

sigma_pos = var(pos_ex);
sigma_neg = var(neg_ex);

score = (mu_pos - mu_neg)^2/(sigma_pos + sigma_neg);
end