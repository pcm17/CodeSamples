%{
I'm not quite sure whats going on, but fairly frequently a histogram 
bin in L2 of the pyramid has no features in it, which causes problems 
later because the dimensions of the bin are 0x0. After debugging a bit, 
I found that the bins without features coorespond to regions in the image 
that are generally all one color or dont have muchchange in color. 
So maybe that's why they're empty?
%}
clc; 
clear;
scenes_dir = [ pwd '/scene_categories' ];
scenes_listing = dir(scenes_dir);
N = length(scenes_listing) - 3;                                             % Skip the first three indicies
num_runs = 4;                                                               % Number of Different KNN values
training_pct = 0.50;                                                        % Training Percent
k_means = 50;                                                               % K-means value
knn = [1,5,25,125];                                                         % K Nearest Neigbors value
[train, test] = get_data(scenes_dir, training_pct);                         % Load images and split into test and training sets
num_images = size(train,1);                                                          % Number of Images used

classes = cell(N, 1);                                                       % Map category (scene) names to integer labels
for i = (1 : N)
    n = i + 3;
    scene_entry = scenes_listing(n);
    classes{i} = scene_entry.name;
end

for run = 1:num_runs
    fprintf('Running KNN with k = %d | Number of images = %d | Training Percent = %.1f\n',knn(run), num_images, training_pct);
    for i = 1:num_images                                                    % Extract features from the training images
    
        train_I = imread(train(i).path);                                    % Read in gray scale training image as single
        test_I = imread(test(i).path);                                      % Read in gray scale test image as single
    
        if size(train_I, 3) == 3
            train_I = rgb2gray(train_I);
        end
        if size(test_I, 3) == 3
            test_I = rgb2gray(test_I);
        end
    
        [test_features, test_descriptors] = vl_sift(single(test_I));        % Compute features of test image
        [train_features, train_descriptors] = vl_sift(single(train_I));     % Compute features of training image
                                                                                
        [~,train_means] = kmeansML(k_means,double(train_descriptors));      % Run kmeansML on training descriptors 
        [~,test_means] = kmeansML(k_means,double(test_descriptors));        % Run kmeansML on testing descriptors
    
        train_im = imread(train(i).path);
        test_im = imread(test(i).path);
    
        pyramids_train(i,:) = computeSPMHistogram(train_im,train_means);    % Compute Training spatial pyramid representations
        pyramids_test(i,:) = computeSPMHistogram(test_im,test_means);       % Compute Testing spatial pyramid representations
    
        labels_train(i) = find(ismember(classes, train(i).category));       % Update training labels
        labels_test(i) = find(ismember(classes, test(i).category));         % Update testing labels
 
    end

    fprintf('Running KKN Classifier');
    [labels] = findLabelsKNN(pyramids_train, pyramids_test, labels_train, knn(run));

    score = computeAccuracy(labels_test, labels);                          
    if score > (1/15)
        fprintf('\nWe did BETTER than random!\tScore = %.3f\n',score)
    else
        fprintf('\nWe did WORSE than random :(\tScore = %.3f\n',score)
    end
end