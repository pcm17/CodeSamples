function [p2] = apply_homography(p1, H)
    p2 = H * p1;
end 
