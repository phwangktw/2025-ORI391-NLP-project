% Problem Number: 8
% Problem Name: rosenbrock_100
% Problem Description: Rosenbrock function. Dimension n = 100

function g = rosenbrock_100_grad(x)
    % x : a column vector
    n = length(x);
    % Initialize gradient vector
    g = zeros(n, 1);

    % Compute the gradient for each component
    g(1) = -400 * x(1) * (x(2) - x(1)^2) - 2 * (1 - x(1));
    for i = 2:n-1
        g(i) = 200 * (x(i) - x(i-1)^2) - 400 * x(i) * (x(i+1) - x(i)^2) - 2 * (1 - x(i));
    end
    g(n) = 200 * (x(n) - x(n-1)^2);
end
