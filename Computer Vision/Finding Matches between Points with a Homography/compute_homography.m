function H = compute_homography(A, B)
%%% Computes homography between keypoints in two images
%%% clustering algorithm
%%% Arguments:      1. points from first image
%%%                 2. points from second image
%%%
%%% Returns:        1. homography 
    assert(size(A, 2) == 2);
    assert(size(B, 2) == 2);
    assert(size(A, 1) == size(B, 1));
        
    eq = [];
    
    for i = 1:size(A, 1)
        x = A(i, 1); 
        y = A(i, 2);
        xp = B(i, 1);
        yp = B(i, 2);
        temp = [-x -y -1 0 0 0 x*xp y*xp xp; 0 0 0 -x -y -1 x*yp y*yp yp];
        eq = [eq; temp];
    end
    
    [~, ~, V] = svd(eq);
    H = V(:, end);
    H = reshape(H, 3, 3)';