data = load('clustering_data.txt');
k = 2;
numDataPoints = size(data,1);
starts = ['sample '; 'cluster'; 'plus   ' ;'uniform'];

nRuns = 200;
reps = 1;
avgDist = zeros(nRuns,2);

lowestDist = zeros(1,4);
score = zeros(nRuns,1);
randBetter = 0;
nRands = 1000;
randPct = zeros(nRuns,1);
randScore = zeros(nRands,1);

for m=1:nRuns
    minDist = 100000000;
    for n = 1:reps
        [minIDX, stC, stSumd] = kmeans(data, k,'Replicates',30);
        minDist = sum(stSumd);
    end
    
    %lowestDist(minDist(m,:) == min(minDist(m,:))) = lowestDist(minDist(m,:) == min(minDist(m,:))) + 1;
    
    labels = load('class_labels.txt');
    labels(labels==0)=2;
    st1 = size(find(minIDX == labels),1);
    %pl1 = size(find(plIDX == labels),1);
    
    labels = load('class_labels.txt');
    labels = labels + 1;
    st2 = size(find(minIDX == labels),1);
    %pl2 = size(find(plIDX == labels),1);
    
    if st1 >= st2
        score(m,1) = (st1/size(labels,1))*100;
    else
        score(m,1) = (st2/size(labels,1))*100;
    end
    
    randBetter = 0;
    for i = 1:nRands
        labels = load('class_labels.txt');
        ix = randperm(size(labels,1));
        labels = labels(ix);
        
        labels2 = labels;
        labels2(labels2 == 0) = 2;
        st1 = size(find(minIDX == labels2),1);
        
        labels1 = labels + 1;
        st2 = size(find(minIDX == labels1),1);

        if st1 >= st2
            randScore(i,1) = (st1/size(labels,1))*100;
        else
            randScore(i,1) = (st2/size(labels,1))*100;
        end
        if randScore(i,1) >= score(m,1)
            randBetter = randBetter + 1;
        end
    end
    randPct(m,1) = randBetter/nRands;
end

avgRandBetter = mean(randPct)
avgScore = mean(score);


figure, hist(randPct);
title({'Percentage of Random Label Agreement Scores';'Higher than True Label Agreement Scores '});

