%%% Expirements with classification using k-means clustering with 
%%% a variety of cluster initialization methods
%%% ****************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Machine Learning, University of Pittsburgh 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = load('clustering_data.txt');
k = 2;      % How many cluster centers
numDataPoints = size(data,1);
starts = {'sample'; 'cluster'; 'plus' ;'uniform'};
nRuns = 3;
reps = 1;
randBetter = 0;
nRands = 1000;
avgDist = zeros(nRuns,2);
lowestDist = zeros(1,4);
score = zeros(nRuns,1);
randPct = zeros(nRuns,1);
randScore = zeros(nRands,1);

for s = 1:length(starts)
    for m=1:nRuns
        [minIDX, stC, stSumd] = kmeans(data, k,'Replicates',30, 'Start', char(starts{s}));
        minDist = sum(stSumd);

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

            % Convert class labels to values of 1 and 2, instead of 0 and 1   
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

    %figure, hist(randPct);
    %title({'Percentage of Random Label Agreement Scores';'Higher than True Label Agreement Scores '});
end

