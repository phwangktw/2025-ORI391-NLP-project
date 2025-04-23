% Problem Number: 7
% Problem Name: rosenbrock_2
% Problem Description: Rosenbrock function. Dimension n = 2

% The Hessian of the Rosenbrock function
function H = rosenbrock_2_Hess(x)
    % x : 2 by 1 vector
    n = length(x);
    
    H = zeros(n,n);  % Initialize the matrix
    
    H(1,1) = 2 -400 * ( x(2) - 3*x(1)^2 );
    H(1,2) = -400*x(1);

    H(2,2) = 200;
    H(2,1) = -400*x(1);

end

