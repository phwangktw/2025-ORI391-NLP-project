% Problem Number: 9
% Problem Name: DataFit_2
% Problem Description: Beale function. Dimension n = 2

% The Beale function
function f = DataFit_2_func(x)
% x : n by 1 vector

% The below is one way to implement Beale function
f = (1.5 - x(1)*(1-x(2)))^2 + (2.25 - x(1)*(1-x(2)^2))^2 + (2.625 - x(1)*(1-x(2)^3))^2;
end