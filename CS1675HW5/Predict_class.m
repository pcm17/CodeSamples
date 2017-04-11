function [ y_pred ] = Predict_class( data, u0, u1, covar )
% Makes class prediction based on model parameters

% Compute prior 
X = data(:,1:2);
N1 = size(find(data(:,3) == 0),1);
N2 = size(find(data(:,3) == 1),1);

prior_y1 = N2/(N1 + N2);
prior_y0 = 1 - prior_y1;

posterior0 = mvnpdf(X,u0,covar);             % Generate pdf for normal distribution with u0 and covar and evaluate at every value of x
posterior1 = mvnpdf(X,u1,covar);             % Generate pdf for normal distribution with u1 and covar and evaluate at every value of x

y_pred = zeros(size(data,1),1);             % Initialize all predictions to 0

for i = 1:size(X,1)
    prob0 = ( posterior0(i) * prior_y0 ) / ( posterior0(i) * prior_y0 + posterior1(i) * prior_y1 );
    prob1 = ( posterior1(i) * prior_y1 ) / ( posterior0(i) * prior_y0 + posterior1(i) * prior_y1 );
    if prob1 > prob0
        y_pred(i,1) = 1;        % If the probabilty of y = 1 > y = 0, predict y = 1
    end
end

end

