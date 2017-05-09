function [quantizedIm, mean_colors, cluster_ids] = quantizeRGB(origIm, k)
%%% Computes a quantized image from the original image using k-means
%%% clustering algorithm
%%% Arguments:      1. original image
%%%                 2. number of clusters
%%%
%%% Returns:        1. quantized image
%%%                 2. cluster center color values
%%%                 3. cluster membership IDs

    %cform = makecform('srgb2lab');
    %labIm = applycform(origIm, cform);
    nrows = size(origIm,1);
    ncols = size(origIm, 2);
    origIm = double(origIm(:,:,:));
    X = reshape(origIm, nrows*ncols, 3);
    [cluster_ids, cluster_centers] = kmeans(X, k, 'Distance', 'sqEuclidean');
    mean_colors = origIm(round(cluster_centers));
    pixel_labels = reshape(cluster_ids, nrows, ncols);
    
    %TRYING TO REPLACE PIXEL VALUES WITH MEAN COLOR OF THAT CLUSTER. 
    %VALUES GET REPLACED BUT WONT SHOW CORRECTLY...
    quantizedIm = zeros(size(origIm,1), size(origIm,2), 3);
    for x = 1:size(origIm,1)
        for y = 1:size(origIm,2)
            for kk = 1:k
                if pixel_labels(x,y) == kk
                    [cluster_ids, cluster_centers] = kmeans(X, k, 'Distance', 'sqEuclidean');
                    mean_colors = origIm(round(cluster_centers));
                    quantizedIm(x,y,1) = int64(mean_colors(kk,1));
                    quantizedIm(x,y,2) = int64(mean_colors(kk,2));
                    quantizedIm(x,y,3) = int64(mean_colors(kk,3));
                end
            end
        end
    end
    quantizedIm = uint8(quantizedIm);
    
    figure, imshow(pixel_labels,[]), title('Image labeled by cluster ID');
    str = sprintf('Quantized image with k = %d', k);
    title(str);
    
end