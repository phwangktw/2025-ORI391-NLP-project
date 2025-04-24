function [x_k, f_val, k, status, computing_time] = newtonCGW(x0, Obj, options)
    % Newton-Conjugate Gradient (Newton-CG) Method
    %
    % Inputs:
    %   x0       - Initial starting point (vector)
    %   f        - Function handle for objective function
    %   grad_f   - Function handle for gradient of f
    %   hess_f   - Function handle for Hessian of f
    %   eta      - Inexact tolerance parameter (default: 0.1)
    %   tol      - Convergence tolerance 
    %   max_iter - Maximum number of iterations
    %
    % Output:
    %   x_opt    - Approximate optimal solution

    eta = options.eta;
    f = Obj.func;
    grad_f = Obj.grad;
    hess_f = Obj.hess;
    alpha_init = options.alpha_init;
    max_iter = options.max_iters;
    tol = options.tol;
    file_name = fullfile(options.outputpath, options.file_name+".mat");

    % Initialization
    x_k = x0;
    result = zeros(max_iter, 3); % store f(x), norm-grad, alpha
    
    tic_time = tic;
    computing_time = 0;
    for k = 1:max_iter
        g_k = grad_f(x_k);  % Compute gradient
        H_k = hess_f(x_k);  % Compute Hessian
        
        % Stopping condition
        if norm(g_k) < tol || computing_time > 600
            break;
        end
        
        % Initialize CG variables
        z_j = zeros(size(x_k));
        r_j = g_k;
        d_j = -r_j;
        
        for j = 0:max_iter
            % Check curvature condition
            Hd_j = H_k * d_j;
            if d_j' * Hd_j <= 0
                if j == 0
                    p_k = -g_k; % Use steepest descent if negative curvature
                else
                    p_k = z_j; % Use computed direction
                end
                break;
            end
            
            % Compute step size for CG iteration
            alpha_j = (r_j' * r_j) / (d_j' * Hd_j);
            
            % Update z_j and r_j
            z_j = z_j + alpha_j * d_j;
            r_j_new = r_j + alpha_j * Hd_j;
            
            % Check inexact Newton condition
            if norm(r_j_new) <= eta * norm(g_k)
                p_k = z_j;
                break;
            end
            
            % Compute beta and update d_j
            beta_j = (r_j_new' * r_j_new) / (r_j' * r_j);
            d_j = -r_j_new + beta_j * d_j;
            r_j = r_j_new;
        end
        
        % Compute step length using Wolfe line search
        alpha_k = wolfe_line_search(x_k, p_k, f, grad_f, alpha_init, options); %add1
        % Update the output matrix
        result(k+1, :) = [f(x_k), norm(grad_f(x_k)), alpha_k];

        % Update iterate
        x_k_prev = x_k;
        x_k = x_k + alpha_k * p_k;
        % Update alph_init for the next iteration
        alpha_init = update_armijo_step(f, x_k, x_k_prev, g_k, p_k);
        computing_time = toc(tic_time);
    end

    %% Execution loop is DONE above, now do the basic parsing

    result = result(1:k-1, :);
    save(file_name, 'result');
    f_val = f(x_k);  % Compute function value at optimal x

    % Computing time
     computing_time = toc(tic_time);

    % Check the reason for stopping the iterations
    if norm(g_k) <= tol
        status = 'optimal solution found';
    elseif computing_time>=600
        status = 'maximum computing time reached';
    else
        status = 'maximum iterations reached';
    end
end