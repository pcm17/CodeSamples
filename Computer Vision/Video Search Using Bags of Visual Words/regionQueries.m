framesdir = [pwd '/frames'];
siftdir = [pwd '/sift'];
fname = [siftdir '/' 'friends_0000001372.jpeg.mat'];
query_im_name = [framesdir '/' 'friends_0000001372.jpeg'];
query_image = imread(query_im_name);

snames = dir(fullfile(pwd, 'sift/*.mat'));
assert(size(fname, 1) > 0);
frnames = dir(fullfile(pwd, 'frames/*.jpeg'));
assert(size(query_im_name, 1) > 0);

load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients')
% Form a query from a region within a frame. 
% Select a polygonal region interactively with the mouse
fprintf('\n\nUse the mouse to draw a polygon, double click to end it\n');
% oninds contains the indices of the SIFT features whose centers fall within the selected region of interest.

%oninds = selectRegion(query_image, positions);

% Compute a bag of words histogram (BOW) from only the SIFT descriptors that fall within that region
k = 100; %1500;
descriptors = descriptors;
[membership, words] = kmeansML(k, descriptors');
words = words';
%bow1 = computeBOWRepr(descriptors(oninds,:), words);
bow1 = computeBOWRepr(descriptors, words);

% Compute BOW for 200 other video frames
similarities = [];
most_sim = 0;
for i = 1:(size(frnames,1)/400) % Only search first half of frames because theres so
        % load the sift file
        fname = [siftdir '/' snames(i).name];
        load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients')
        % Compute bag of words for this image
        %size(descriptors,1)
        if size(descriptors,1) ~= 0 % for frames that are all black, the first dimension of descriptors is empty because no feature points are detected
            [membership, words] = kmeansML(k, descriptors');
            words = words';
            bow2 = computeBOWRepr(descriptors, words);
            sim = compareSimilarity(bow1, bow2);
            if sim > most_sim
                most_sim = sim;
                most_sim_name = imname;
            end
        end
end

similarities = sort(similarities);

im = imread([framesdir '/' most_sim_name]);
figure, imshow(query_image)
title('Query Image')
figure, imshow(im)
title('Closest match')
% HOW DO I 
%im = imread([framesdir '/' second_sim_name]);
%figure, imshow(im)
%title('Second closest match')

