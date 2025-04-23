function alpha = wolfe_line_search(x_k, p_k, f, grad_f, alpha_init, options)
    % Wolfe conditions line search algorithm.
    %
    % Inputs:
    %   x_k    - Current iterate (vector)
    %   p_k    - Search direction (vector)
    %   f      - Function handle for objective function
    %   grad_f - Function handle for gradient of f
    %   c1     - Parameter for Armijo condition (default: 1e-4)
    %   c2     - Parameter for curvature condition (default: 0.9)
    %
    % Output:
    %   alpha  - Step size satisfying Wolfe conditions
    
    % Initialize parameters
    c2 = options.c2; 
    c1 = options.c1;
    % Initialization
    alpha_l = 0;
    alpha_u = inf;
    alpha = alpha_init; % Initial step size

    phi_0 = f(x_k);
    phi_grad_0 = grad_f(x_k)' * p_k;

    while true
        % Evaluate function and gradient at alpha
        phi_alpha = f(x_k + alpha * p_k);
        phi_grad_alpha = grad_f(x_k + alpha * p_k)' * p_k;

        % Check Armijo condition
        if phi_alpha > phi_0 + c1 * alpha * phi_grad_0
            alpha_u = alpha; % Reduce the upper bound
        else
            % Check curvature condition
            if phi_grad_alpha < c2 * phi_grad_0
                alpha_l = alpha; % Increase the lower bound
            else
                % Wolfe conditions satisfied, return alpha
                return;
            end
        end

        % Update step size
        if alpha_u < inf
            alpha = (alpha_l + alpha_u) / 2; % Bisection method
        else
            alpha = 2 * alpha; % Exponential increase
        end
    end
end
