% Problem Number: 9
% Problem Name: DataFit_2
% Problem Description: Beale function. Dimension n = 2
% The Hessian of the Rosenbrock function

% The Beale function
function H = DataFit_2_Hess(x)

    
    H = zeros(2,2);  % Initializa the matrix
    
    H(1,1) = 2*(1-x(2))^2 + 2*(1-x(2)^2)^2 +2*(1-x(2)^3)^2 ;
    H(2,2) = 2*x(1)^2 + 4*x(1) * (2.25 - x(1)*(1-x(2)^2)) + 8*x(1)^2*x(2)^2 + 12*x(1)*x(2)*(2.625 - x(1)*(1-x(2)^3)) + 18*x(1)^2*x(2)^4;

    H(1,2)=2*(1.5-x(1)*(1-x(2)))+2*x(1)*(x(2)-1)+4*(2.25-x(1)*(1-x(2)^2))*x(2)+4*x(1)*x(2)*(x(2)^2-1)+6*(2.625-x(1)*(1-x(2)^3))*x(2)^2+6*x(1)*x(2)^2*(x(2)^3-1); 
    H(2,1) = H(1,2);


end