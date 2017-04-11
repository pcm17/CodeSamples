function [ discrete_data ] = discretize_attribute( X, k )
    bin_size = (max(X) - min(X))/k;
    bin_num = 2;
    edges = zeros(k-1,1);
    edges(1) = 0;
    while (bin_num <= k)
        edges(bin_num) = bin_size*(bin_num-1);
        bin_num = bin_num + 1;
    end
    discrete_data = discretize(X, edges);
end

