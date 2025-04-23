% Problem Number: 9
% Problem Name: DataFit_2
% Problem Description: Beale function. Dimension n = 2

% The Beale function
function g = DataFit_2_grad(x)

    g = zeros(2, 1);

    % Compute the gradient for each component
    g(1) = -2* (1.5 - x(1)*(1-x(2)))* (1-x(2)) -2*(2.25 - x(1)*(1-x(2)^2)) * (1-x(2)^2) + -2*(2.625 - x(1)*(1-x(2)^3))*(1-x(2)^3);
    
    g(2) = 2* (1.5 - x(1)*(1-x(2)))*x(1) +2*(2.25 - x(1)*(1-x(2)^2))*2*x(1)*x(2)+2*(2.625 - x(1)*(1-x(2)^3))*3*x(1)*x(2)^2;

end
