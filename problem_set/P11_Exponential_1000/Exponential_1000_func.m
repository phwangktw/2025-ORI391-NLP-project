% Problem Number: 10
% Problem Name: Exponential_1000
% Problem Description: Exponential_1000 function. Dimension n = 100

% The Exponential_1000 function
function f = Exponential_1000_func(x)
    % x : a column vector

    f = 0.1*exp(-x(1)) + (exp(x(1))-1)/(exp(x(1))+1) + sum((x(2:end)-1).^4);
    
end
