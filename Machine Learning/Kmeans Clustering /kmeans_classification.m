%%% Expirements with classification using k-means clustering 
%%% ****************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Machine Learning, University of Pittsburgh 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = load('clustering_data.txt');
numDataPoints = size(data,1);

nRuns = 30;
k = 2;      % How many classes
allIDX = zeros(size(data,1), nRuns);
allDist = zeros(nRuns,1);
s1 = zeros(nRuns,1);
s2 = zeros(nRuns,1);
score = zeros(nRuns,1);

for n=1:nRuns
    %centers = c{n,1};
    [IDX, C, sumd] = kmeans(data, k);
    allDist(n,1) = sum(sumd);
    
    labels = load('class_labels.txt');
    labels(labels == 0) = 2;
    s1(n,1) = size(find(IDX == labels),1);
    
    labels = load('class_labels.txt');
    labels = labels + 1;
    s2(n,1) = size(find(IDX == labels),1);
    
    if s1(n,1) >= s2(n,1)
        score(n,1) = (s1(n,1)/size(labels,1))*100;
    else
        score(n,1) = (s2(n,1)/size(labels,1))*100;
    end
end

minDis = allDist(allDist == min(allDist));
minDistScore = score(allDist == min(allDist));
maxScore = score(score == max(score));
distMaxScore = allDist(score == max(score));
avgScore = mean(score);

fprintf('Top Accuracy = %.2f\nAverage Accuracy = %.2f\n',[maxScore, avgScore]);

