% Problem Number: 8
% Problem Name: rosenbrock_100
% Problem Description: Rosenbrock function. Dimension n = 100

% The Rosenbrock function
function f = rosenbrock_100_func(x)
% x : 100 by 1 vector

% The below is one way to implement Rosenbrock function
f = sum(100 * (x(2:end)-x(1:end-1).^2).^2 + (1-x(1:end-1)).^2);
end