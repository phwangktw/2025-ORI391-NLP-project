% Problem Number: 10
% Problem Name: Exponential_1000
% Problem Description: Exponential_1000 function. Dimension n = 100

% The Exponential_1000 function
function g = Exponential_1000_grad(x)
    % x : a column vector
    n = length(x);
    g = zeros(n,1);

    g(1) = -0.1*exp(-x(1)) + 2*exp(x(1))/((exp(x(1))+1)^2);

    for i = 2:n
        g(i) = 4*(x(i)-1)^3;
    end
    
end
