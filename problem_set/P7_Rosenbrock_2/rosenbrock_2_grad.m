% Problem Number: 7
% Problem Name: rosenbrock_2
% Problem Description: Rosenbrock function. Dimension n = 2

function g = rosenbrock_2_grad(x)

    % Initialize gradient vector (2 by 1)
    g = zeros(2, 1);

    % Compute the gradient for each component
    g(1) = -400 * x(1) * (x(2) - x(1)^2) - 2 * (1 - x(1));
    g(2) = 200 * (x(2) - x(1)^2);
end
