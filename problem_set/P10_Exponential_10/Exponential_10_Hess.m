% Problem Number: 9
% Problem Name: Exponential_10
% Problem Description: Exponential_10 function. Dimension n = 10

% The Exponential_10 function
function h = Exponential_10_Hess(x)
    % x : a column vector
    n = length(x);
    h = zeros(n,n);

    h(1,1) = 0.1* exp(-x(1)) + 2*exp(x(1))*(1-exp(x(1)))/((exp(x(1))+1)^3);

    for i = 2:n
        
        h(i,i) = 12*(x(i)-1)^2;

    end
    
end