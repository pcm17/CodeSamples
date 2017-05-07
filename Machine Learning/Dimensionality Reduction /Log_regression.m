function W = Log_regression(X, Y, W, k)
%%% Logistic Regression
% Arguments:    1. features
%               2. class values
%               3. weights
%               4. iteration 
% Returns:  updated weights vector
    sum_err = 0;                    %%% initialize batch error function gradient
    for row = 1:1:size(X, 1)
        x = X(row,:)';
        y = Y(row,:);
        f = 1/(1 + exp(-(W'*x)));
        err = (y - f) * x;          % error (on-line gradient)
        sum_err = sum_err + err;    % update batch error function gradient
    end
    alpha = 2/k;
    W = W + (alpha * sum_err);
end