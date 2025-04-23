% Problem Number: 7
% Problem Name: rosenbrock_2
% Problem Description: Rosenbrock function. Dimension n = 2

% The Rosenbrock function
function f = rosenbrock_2_func(x)
% x : 2 by 1 vector

% The below is one way to implement Rosenbrock function
f = sum(100 * (x(2:end)-x(1:end-1).^2).^2 + (1-x(1:end-1)).^2);
end