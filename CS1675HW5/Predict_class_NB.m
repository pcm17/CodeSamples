function [ y_pred ] = Predict_class_NB( data, mu, sigma )
% Makes class prediction based on model parameters

pos_data = data(data(:,3) == 1,:);
neg_data = data(data(:,3) == 0,:);

% Compute prior 
X = data(:,1:2);
N1 = size(find(data(:,3) == 0),1);
N2 = size(find(data(:,3) == 1),1);

prior_y1 = N2/(N1 + N2);
prior_y0 = 1 - prior_y1;
x1 = X(:,1);
x2 = X(:,2);

pd10 = normpdf(x1,mu(1,1), sigma(1,1)); 
pd11 = normpdf(x1,mu(1,2), sigma(1,2)); 
pd20 = normpdf(x2,mu(2,1), sigma(2,1)); 
pd21 = normpdf(x2,mu(2,2), sigma(2,2)); 

y_pred = zeros(size(data,1),1);     % Initialize prediction array

for i = 1:size(data,1)
    prob0 = (pd10(i)*pd20(i)) * prior_y0;
    prob1 = (pd11(i)*pd21(i)) * prior_y1;
    if prob1 > prob0
        y_pred(i,1) = 1;
    end
end


end

