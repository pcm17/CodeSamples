%This is the script is used to test my functions

data = load('pima.txt');
attributes = {'Times Pregnant', 'Glucose Conc.', 'Diastolic Blood Pressure', 'Triceps Skin Fold Thickness', '2-Hour Serum Insulin', 'Body Mass Index', 'Diabetes Pedigree Function', 'Age (years)'};

%
for i = 1:8
    for j = 1:8
        scatter_plot(data(:,i),data(:,j), attributes(i), attributes(j));
    end
end


%{
for i =1:8
    histogram_analysis(data(:,i), attributes(i));
end
%}
normalized_data = normalize(data(:,3));
k = 10;
[ discrete_data ] = discretize_attribute( data(:,3), k );

yes_diabetes = [];
no_diabetes = [];
for i = 1:size(data,1)
    if (data(i,9) == 0)
        no_diabetes = [no_diabetes; data(i,:)];
    else
        yes_diabetes = [yes_diabetes; data(i,:)];
    end
    
end
no_mean = mean(no_diabetes);
no_std = std(no_diabetes);
yes_mean = mean(yes_diabetes);
yes_std = std(yes_diabetes);
p_train = 0.66;

size_training = [];
for i = 1:20
    [ data_train, data_test ] = divideset1( data, p_train );
    size_training = [size_training;size(data_train,1)];
end
        
avg_size_training = mean(size_training);

[ data_train, data_test ] = divideset2( data, p_train );