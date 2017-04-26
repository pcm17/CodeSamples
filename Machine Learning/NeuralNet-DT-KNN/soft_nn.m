function [y_pred] = soft_nn(x, y, xn, h)
    N = size(x,1);
    vote1 = 0;
    vote0 = 0;
    for n = 1:N % Look through all Training data points
        xi = x(n,:);
        u = sqrt(sum((xi - xn).^2));
        K = (1/sqrt(2*pi))*exp(- u.^2/(2*h^2));
        if (y(n) == 0)
            vote0 = vote0 + (1/(N*h))*K;
        else
            vote1 = vote1 + (1/(N*h))*K;
        end
    end
 
    if (vote1 >= vote0)
        y_pred = 1;
    else
        y_pred = 0;
    end
    
end