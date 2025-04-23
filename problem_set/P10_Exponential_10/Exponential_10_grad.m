% Problem Number: 9
% Problem Name: Exponential_10
% Problem Description: Exponential_10 function. Dimension n = 10

% The Exponential_10 function
function g = Exponential_10_grad(x)
    % x : a column vector
    n = length(x);
    g = zeros(n,1);

    g(1) = -0.1*exp(-x(1)) + 2*exp(x(1))/((exp(x(1))+1)^2);

    for i = 2:n
        g(i) = 4*(x(i)-1)^3;
    end
    
end
