function [ result ] = beta_fxn( a, b, theta )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    result = (gamma_fxn(a+b)/(gamma_fxn(a)*gamma_fxn(b)))*theta^(a-1)*(theta-1)^(b-1);
end

