data = [0 0;0 5;6 7;7 0];
data = load('clustering_data.txt');
%c = cell(2,1);
%c{1,1} = [0 0;7 0];
%c{2,1} = [3,3;7,0];
numDataPoints = size(data,1);

numRuns = 30;
k = 2;
allIDX = zeros(size(data,1), numRuns);
allDist = zeros(numRuns,1);
s1 = zeros(numRuns,1);
s2 = zeros(numRuns,1);

for n=1:numRuns
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

fprintf('%d %d\n',s1,s2)
fprintf('%.2f\n',allDist);
minDis = allDist(find(allDist == min(allDist)))
minDistScore = score(find(allDist == min(allDist)))
maxScore = score(find(score == max(score)))
distMaxScore = allDist(find(score == max(score)))

avgScore = mean(score);


