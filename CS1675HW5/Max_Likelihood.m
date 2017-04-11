function [ u0, u1, covar ] = Max_Likelihood( data )
% Computes ML estimate parameters
pos_data = data(data(:,3) == 1,:);   % Isolate Data with y = 1
neg_data = data(data(:,3) == 0,:);  % Isolate Data with y = 0

x0 = neg_data(:,1:2);
x1 = pos_data(:,1:2);
x = data(:,1:2);

u0 = mean(x0);
u1 = mean(x1);
covar = cov(x);
end

