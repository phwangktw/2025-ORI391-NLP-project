% Problem Number: 8
% Problem Name: rosenbrock_100
% Problem Description: Rosenbrock function. Dimension n = 100

% The Hessian of the Rosenbrock function
function H = rosenbrock_100_Hess(x)
    % x : n by 1 vector
    n=length(x);
    
    H = zeros(n,n);  % Initializa the matrix
    
    H(1,1) = 2 -400 * ( x(2) - 3*x(1)^2 );
    H(1,2) = -400*x(1);
           
    for i=2:n-1
        H(i,i) = 202 -400* (x(i+1) -3*x(i)^2);
        H(i,i-1) = -400*x(i-1);
        H(i,i+1) = -400*x(i);
    end

    H(n,n) = 200;
    H(n,n-1) = -400*x(n-1);


end

