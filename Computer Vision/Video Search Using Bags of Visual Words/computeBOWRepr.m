function [bow] = computeBOWRepr(descriptors, means)
    % Computes a Bag-of-Words (BOW) representation of an image or image region (polygon)
    % INPUTS:
    %       descriptors     :   A Mx128 set of descriptors for the image or image region
    %       means           :   A 128xk set of cluster means. These are our
    %                           "words"   
    %
    % OUTPUT:
    %       bow             :   A normalized bag-of-words histogram 
    k = 1;
    % Maps a raw SIFT descriptor to its nearest visual word
    % Assigns the raw descriptor to the nearest visual word 
    % Computes the index of the cluster mean center that the descriptor is
    % closest to (Euclidean distance)
    distance = dist2(means, descriptors);
    [distance, idx] = sort(distance);
    distance = distance (1:k,:);
    idx = idx (1:k,:);
    % Map an image or region's features into its bag-of-words histogram
    bow = hist(double(idx), 1:size(means, 1));
    bow = bow/sum(bow);
    bow = bow';
end
