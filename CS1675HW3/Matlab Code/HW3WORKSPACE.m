%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Problem 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = load('coint.txt');
heads = data == 1;
num_heads = sum(heads);
tosses = size(data,1);
theta = num_heads / tosses;
n1 = num_heads;
n2 = tosses - n1;

a = 4;
b = 2;
theta = 0:0.01:1;
for i=1:size(theta,2)
    beta(i) = abs(beta_fxn(a,b,theta(i)));
end

figure, plot(theta,beta);
title(['Prior Distribution' 10 'a = ' num2str(a) ' b = ' num2str(b)]);

for i=1:size(theta,2)
    beta(i) = beta_fxn(a+n1,b+n2,theta(i));
end
figure,plot(theta,beta);
title(['Posterior Distribution'  10 'a = ' num2str(a) ' b = ' num2str(b)]);

map_estimate = (a + n1 - 1)/(a + b + n1 + n2 - 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Problem 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data = load('gaussian.txt');
x1 = data(:,1);
x2 = data(:,2);
%scatter(X,Y);
mu = mean (data);
sigma = cov(data);


[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu,sigma);
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
axis([0 6 4 10 0 .05])
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');

meas1 = data(:,1);
meas2 = data(:,2);

u1 = mean(meas1);
u2 = mean(meas2);


var1 = var(meas1);
var2 = var(meas2);

F1 = normpdf(meas1,u1,var1);
figure,plot(meas1,F1,'+')
title('Gaussian Measurement 1 Data');
F2 = normpdf(meas2,u2,var2);
figure,plot(meas2,F2,'+')
title('Gausian Measurement 2 Data');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Problem 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = load('poisson.txt');
n = size(x,1);

mle = (1/n)*sum(x);
gam = [2, 6, mle];
for i = 1:3
    p = poisspdf(x,gam(i));
    figure,plot(x,p, '+')
    title(['Gamma = '  num2str(gam(i))])
end

a = 1;
b = 2;
c = 0:.1:2;
c = c(1:20);
conjPrior = gampdf(c, a, b);

%figure, plot(c,conjPrior,'+');
%title(['Conjugate Prior Distribution' 10 'a = ' num2str(a) ' b = ' num2str(b)]);

a_ = a + sum(x);
b_ = b/(n*b+1);
posterior = gampdf(c,a_,b_);
figure, plot(c,posterior,'+');
title(['Posterior Distribution' 10 'a = ' num2str(a) ' b = ' num2str(b)]);



