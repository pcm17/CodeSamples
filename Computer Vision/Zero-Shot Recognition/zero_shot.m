clc;
num_test_images = size(set_B_animals,1);
num_attributes = 85;
num_classes = 10;

for i = 1:10,
   test_ground_truth_attributes(i,:) = M(test_ids(i),:);
end


for i = 1:num_attributes
        attribute = cell2mat(attr_probs(i));
        positive_attributes(:,i) = attribute(:,1);   % Rows are images and columns are attributes
        negative_attributes(:,i) = attribute(:,2);
end

probs = zeros(num_classes,num_attributes); % The probability that the query image belongs to each class
classification = zeros(num_test_images,1);
for n = 1:num_test_images
    for i = 1:num_classes
        for j = 1:num_attributes
            if test_ground_truth_attributes(i,j) == 1   % Positive attribute
                probs(i,j) = positive_attributes(n,j);
            else
                probs(i,j) = negative_attributes(n,j);  % Negative attribute
            end
        end
    end
    class_probs = prod(probs,2);
    [~, ind] = max(class_probs);
    classification(n) = test_ids(ind);
end
zero_shot_accuracy = sum(set_B_animals(:) == classification(:))/num_test_images*100;



    
