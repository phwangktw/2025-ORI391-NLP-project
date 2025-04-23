% Problem Number: 9
% Problem Name: Exponential_10
% Problem Description: Exponential_10 function. Dimension n = 10

% The Exponential_10 function
function f = Exponential_10_func(x)
    % x : a column vector

    f = 0.1*exp(-x(1)) + (exp(x(1))-1)/(exp(x(1))+1) + sum((x(2:end)-1).^4);
    
end
