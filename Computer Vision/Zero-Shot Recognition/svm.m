% X_train are training (set_A_samples) features 
% Y_train are training (set_A_animals) labels
% X_test are test (set_B_samples) features
X_train = set_A_samples;
Y_train = set_A_animals;
X_test = set_B_samples;
num_test_images = size(set_B_animals,1);

model = fitcecoc(X_train, Y_train);
labels = predict(model, X_test);

svm_accuracy = sum(set_B_animals(:) == labels(:))/num_test_images*100;
