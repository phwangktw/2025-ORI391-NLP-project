%% Modified Newton Direction Calculation with Cholesky PD Correction
function [Bk, delta] = cholesky_hessian_correction(H, beta)
    % where B = H + Ek ensures PD using Cholesky modification.
    %
    % Inputs:
    %   hess - Hessian matrix
    %   beta - Initial small value to ensure PD
    % Output:
    %   Bk - Modified Hessian
    
    % Ensure Hessian is Positive Definite using Cholesky
    I = eye(length(H)); % Identity matrix
    
    % Initialize perturbation
    min_diag = min(diag(H));
    if min_diag > 0
        delta = 0;
    else
        delta = -min_diag + beta;
    end
    
    while true
        try
            % Attempt Cholesky decomposition
            R = chol(H + delta * I);
            break;  % If successful, H + tau*I is PD
        catch
            % If Cholesky fails, increase tau and retry
            delta = max(2 * delta, beta); 
        end
    end
    Bk = H + delta * I;  % Modified Hessian ensuring PD
end