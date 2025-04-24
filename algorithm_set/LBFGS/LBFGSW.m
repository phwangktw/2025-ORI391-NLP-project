function [x_k, f_val, k, status, computing_time] = LBFGSW(x0, Obj, options)
    % Limited-Memory BFGS (L-BFGS) Method with Wolfe Line Search
    %
    % Inputs:
    %   x0       - Initial starting point (vector)
    %   f        - Function handle for objective function
    %   grad_f   - Function handle for gradient of f
    %   m        - Memory size (number of stored updates)
    %   tol      - Convergence tolerance (default: 1e-6)
    %   max_iter - Maximum number of iterations (default: 100)
    %
    % Output:
    %   x_opt    - Approximate optimal solution

    
    f = Obj.func;
    grad_f = Obj.grad;
    hess_f = Obj.hess;
    alpha_init = options.alpha_init;
    m = options.m; % memory size
    epsilon_min = options.epsilon_min;  % Threshold for updating H_k
    max_iter = options.max_iters;
    tol = options.tol;
    file_name = fullfile(options.outputpath, options.file_name+".mat");

    % Initialization
    n = length(x0);
    x_k = x0;
    result = zeros(max_iter, 3); % store f(x), norm-grad, alpha
    k = 0;
    S = [];  % Storage for s_k (previous step changes)
    Y = [];  % Storage for y_k (gradient changes)
    
    H0 = eye(n);  % Initial inverse Hessian approximation (scalar identity)
    tic_time = tic;
    computing_time = 0;
    while k < max_iter
        % Compute search direction using L-BFGS two-loop recursion
        q = grad_f(x_k);
        alpha = zeros(size(S, 2), 1);
        rho = zeros(size(S, 2), 1);
        
        for i = size(S, 2):-1:1
            rho(i) = 1 / (Y(:, i)' * S(:, i));
            alpha(i) = rho(i) * (S(:, i)' * q);
            q = q - alpha(i) * Y(:, i);
        end
        
        r = H0 * q;
        
        for i = 1:size(S, 2)
            beta = rho(i) * (Y(:, i)' * r);
            r = r + S(:, i) * (alpha(i) - beta);
        end
        
        p_k = -r; % Search direction
        
        % Compute step length using Wolfe line search
        alpha_k = wolfe_line_search(x_k, p_k, f, grad_f, alpha_init, options);
        % Update the output matrix
        result(k+1, :) = [f(x_k), norm(grad_f(x_k)), alpha_k];

        % Update the iterate
        x_k1 = x_k + alpha_k * p_k;
        
        % Compute differences
        s_k = x_k1 - x_k;
        y_k = grad_f(x_k1) - grad_f(x_k);
        
        % Store correction pairs if condition is met
        if y_k' * s_k > epsilon_min * norm(y_k) * norm(s_k)
            if size(S, 2) >= m
                % Remove the oldest pair
                S(:, 1) = [];
                Y(:, 1) = [];
            end
            % Append new correction pair
            S = [S, s_k];
            Y = [Y, y_k];
        end
        
        % Update x_k
        x_k = x_k1;
        k = k + 1;

        % Check convergence
        if norm(grad_f(x_k)) < tol
            result(k+1, :) = [f(x_k), norm(grad_f(x_k)), alpha_k];
            break;
        end
    end
    %% Execution loop is DONE above, now do the basic parsing
    result = result(1:k-1, :);
    save(file_name, 'result');
    f_val = f(x_k);  % Compute function value at optimal x

    % Computing time
     computing_time = toc(tic_time);

    % Check the reason for stopping the iterations
    if norm(grad_f(x_k)) <= tol
        status = 'optimal solution found';
    elseif computing_time>=600
        status = 'maximum computing time reached';
    else
        status = 'maximum iterations reached';
    end
end