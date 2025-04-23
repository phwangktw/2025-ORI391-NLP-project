%% Function to Update Armijo Initial Step Length
function alpha_init = update_armijo_step(f, x_k, x_k_prev, g_k, pk)
    % Updates the initial step size for Armijo Backtracking
    % Formula: alpha_k_init = 2(f(x_k) - f(x_k_prev)) / (-||∇f(x_k)||^2)
    % Inputs:
    %   f - Function handle for f(x)
    %   x_k - Current iterate x_k
    %   x_k_prev - Previous iterate x_{k-1}
    %   g_k - Gradient at x_k (∇f(x_k))
    % Output:
    %   alpha_init - Updated initial step length
    
    % Compute function values at x_k and x_k_prev
    f_k = f(x_k);
    f_k_prev = f(x_k_prev);
    
    % Compute current gradient phi'(0)
    phi0 = g_k'*pk;

    % Ensure denominator is not zero
    if abs(phi0) > 1e-12
        alpha_init = 2 * (f_k - f_k_prev) / (phi0);
    else
        alpha_init = 1;  % Default value if gradient is too small
    end
end