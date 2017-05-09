function [verticalSeam] = find_optimal_vertical_seam(M)
%%% Finds the optimal vertical path to carve a seam in the given image
%%% Arguments:      1. image
%%%
%%% Returns:        1. optimal vertical path
    [num_rows, num_cols] = size(M);

    verticalSeam = zeros(num_rows, 1);
    
    [~, ind] = min(M(num_rows, :));
    verticalSeam(num_rows) = ind;
    
    for i = num_rows:-1:2
        if( (ind > 1) && (ind < num_cols) )
            [~, ind_new] = min([M(i-1, ind-1) M(i-1, ind) M(i-1, ind+1)]);
            ind = ind-2 + ind_new;
        elseif(ind > 1)
            [~, ind_new] = min([M(i-1, ind-1) M(i-1, ind)]);
            ind = ind-2 + ind_new;
        elseif(ind < num_cols)
            [~, ind_new] = min([M(i-1, ind) M(i-1, ind+1)]);
            ind = ind-1 + ind_new;
        else
            % index stays the same
        end
        verticalSeam(i-1) = ind;
    end
    
        
    
    