function [ mu, sigma ] = Max_Likelihood_NB( data )
% Computes ML estimate parameters
pos_data = data(data(:,3) == 1,:);
neg_data = data(data(:,3) == 0,:);

x10 = neg_data(:,1);
x20 = neg_data(:,2);
x11 = pos_data(:,1);
x21 = pos_data(:,2);

mu(1,1) = mean(x10);
mu(2,1) = mean(x20);
mu(1,2) = mean(x11);
mu(2,2) = mean(x21);

sigma(1,1) = std(x10);
sigma(1,2) = std(x11);
sigma(2,1) = std(x20);
sigma(2,2) = std(x21);

end

