function [labels] = findLabelsKNN(pyramids_train, pyramids_test, labels_train, k)
%{ 
Predicts the labels of the test images using the KNN classifier
INPUT
    pyramids_train     Mx1 cell array
    pyramids_test      Nx1 cell array
    pyramids{i}        1xd Spatial Pyramid Match representation of the corresponding training or test image
    labels_train       Mx1 vector of training labels
    k                  K in K-Nearest Neighbors
OUTPUT
    labels             Nx1 vector of predicted labels for the test images
%}
num_train = size(pyramids_train,1);
num_test = size(pyramids_test,1);

for i=1:num_test
    % For each test image descriptor, compute Euclidean distance to all training images r    
    distance = dist2(pyramids_test(i,:), pyramids_train);
    
    % Find the k closest neighbors among the training images
    [~, position] = sort(distance, 'ascend');
    nearest_neighbors = position(1:k);
    nearest_distances = dist(1:k);
    
    % Voting: Neighbors vote for their label to be assigned to the test image. 
    votes = zeros(size(15,1));
    for n = 1:k
        votes(n) = labels_train(nearest_neighbors(n));
    end

    % Assign the test image the most common value among the labels
    M = mode(votes);
    labels(i) = M;
end


end