function [p2] = apply_homography(p1, H)
%%% Uses the computed homography to compute where a point from the first
%%% image "lands" in the second image
%%% Arguments:      1. point coordinates in first image
%%%                 2. homography
%%%
%%% Returns:        1. computed point coordinates in second image
    p2 = H * p1;
end 
