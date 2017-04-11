%%%%%%%%%%%%%%%%%%%%%%% Problem 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%
data = load('coint.txt');
heads = data == 1;
num_heads = sum(heads);
tosses = size(data,1);
theta = num_heads / tosses;
n1 = num_heads;
n2 = tosses - n1;

a = 2;
b = 2;
theta = 0:0.01:1;
for i=1:size(theta,2)
    beta(i) = abs(beta_fxn(a,b,theta(i)));
end

figure, plot(theta,beta);
title('Prior Distribution');

for i=1:size(theta,2)
    beta(i) = beta_fxn(a+n1,b+n2,theta(i));
end
figure,plot(theta,beta);
title('Posterior Distribution');

map_estimate = (a + n1 - 1)/(a + b + n1 + n2 - 2);

%%%%%%%%%%%%%%%%%%%%%%% Problem 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%

data = load('

