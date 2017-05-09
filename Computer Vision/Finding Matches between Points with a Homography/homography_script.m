%%% Experiments with finding matches between points with a homography
%%% ****************************************************************
%%% Peter McCloskey
%%% CS 1675 Intro to Computer Vision, University of Pittsburgh 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

keble1 = imread('keble1.png');              % Read in the images
keble2 = imread('keble2.png');


A = [164 77;161 146;298 190;338 14];        % Coordinates of distinctive points in keble1 manually picked
B = [68 88; 64 159;199 203;242 33];         % Coordinates of distinctive points in keble2 manually picked

H = compute_homography(A, B);               % Compute the homography

p1 = [262;145;1];                           % Test point, chosen sort of randomly
p2 = apply_homography(p1, H);
p2 = [round(p2(1)/p2(3)) round(p2(2)/p2(3))];


figure, imshow(keble1)
title('keble1')
impixelinfo
hold on
plot(p1(1), p1(2), 'y*')
hold off

figure, imshow(keble2)
title('keble2')
impixelinfo
hold on
plot(p2(1), p2(2), 'y*')
hold off

% when [61;115] is used as the coordinates for the pixel from keble1, 
% the pixel "lands" at [157,103]