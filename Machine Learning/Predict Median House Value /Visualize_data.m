%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Problem 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data_train = load('data/housing.txt');
target = 14;

for i = 1:13
    x = corrcoef(data_train(:,i),data_train(:,14));
    coef(i,1) = x(1,2);  % Save the correlation coefficient between attribute i and the target
    scatter_plot(data_train(:,i),data_train(:,target),i,target);
end

%clear coef

%coef = corrcoef(data_train);
%coef(coef == 1) = 0;

[x_pos y_pos] = find(coef == max(max(coef)));
[x_neg y_neg] = find(coef == min(min(coef)));







