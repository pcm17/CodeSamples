train_data = load('pima_train.txt');
test_data = load('pima_test.txt');
num_features = size(train_data,2) - 1;

X_train = train_data(:,1:num_features);
X_test = test_data(:,1:num_features);

y_train = train_data(:,num_features+1);
y_test = test_data(:,num_features+1);

class_1_train_data = train_data(train_data(:,num_features+1) == 1,1:num_features);
class_0_train_data = train_data(train_data(:,num_features+1) == 0,1:num_features);

class_1_test_data = test_data(test_data(:,num_features+1) == 1,1:num_features);
class_0_test_data = test_data(test_data(:,num_features+1) == 0,1:num_features);

for i = 5:num_features
   %figure, histogram_analysis(class_1_train_data(:,i));
   %title(['Class 1\nFeature: ' num2str(i)]); 
end
for i = 5:num_features
   %figure, histogram_analysis(class_0_train_data(:,i));
   %title(['Class 0\nFeature: ' num2str(i)]); 
end
