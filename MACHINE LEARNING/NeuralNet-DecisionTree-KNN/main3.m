%%%% load the train and test data (both are normalized)
load pima_train.txt;
load pima_test.txt;
load pima.txt

tr_data = pima_train;
test_data = pima_test;
data = pima;

data_col= size(tr_data,2);
n_features = data_col - 1;

%%% create x
x = tr_data(:,1:n_features);
%x = normalize(x);
%% create y vector
y=tr_data(:,data_col);

%% builds x for the the test set
x_test = test_data(:,1:n_features);
%x_test = normalize(x_test);
%% builds y vector for the test set
y_test = test_data(:,data_col);

A = 100;
I = size(x_test,1);
hvals = linspace(0.01,1,A);
for a = 1:A
    h = hvals(a);
    for i = 1:I
        y_pred(i,1) = soft_nn(x, y, x_test(i,:), h);
    end
    
    error= sum(abs(y_pred-y_test))/size(y_test,1);
    accuracy(a) = 1-error

end

plot(hvals,accuracy,'k-');
xlabel('Kernel Smoothing value(h)');
ylabel('Classification Accuracy');
title('Kernel Smoothing value(h) vs Classification Accuracy');

