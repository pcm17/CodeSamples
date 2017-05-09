% small demo to show how clusters form with various values of k

k = 7;
N = ceil(50 * rand(100, 2));

figure; hold on
for i = 1:size(N, 1)
    plot(N(i, 1), N(i, 2), 'ko');
end

inds = kmeans(N, k);

colored_markers = {'ro', 'go', 'bo', 'yo', 'co', 'mo', 'ko'};

figure; hold on
for i = 1:size(N, 1)
    cluster_id = inds(i);
    cluster_marker = colored_markers{cluster_id};
    plot(N(i, 1), N(i, 2), cluster_marker);  
end