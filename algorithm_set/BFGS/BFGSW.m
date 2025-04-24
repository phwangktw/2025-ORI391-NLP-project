function [x_k, f_val, k, status, computing_time] = BFGSW(x0, Obj, options)
%     x0, , , , , , 
    % BFGS Method with Wolfe Line Search
    %
    % Inputs:
    %   x0       - Initial starting point (vector)
    %   f        - Function handle for objective function
    %   grad_f   - Function handle for gradient of f
    %   tol      - Convergence tolerance (default: 1e-6)
    %   max_iter - Maximum number of iterations (default: 100)
    %
    % Output:
    %   x_opt    - Approximate optimal solution

    f = Obj.func;
    grad_f = Obj.grad;
    epsilon_min = options.epsilon_min;  % Threshold for updating H_k
    alpha_init = options.alpha_init;
    max_iter = options.max_iters;
    tol = options.tol;
    file_name = fullfile(options.outputpath, options.file_name+".mat");

    tic_time = tic;
    computing_time = 0;

    % Initialization
    n = length(x0);
    H_k = eye(n);  % Initial inverse Hessian approximation
    x_k = x0;
    k = 0;
    
    result = zeros(max_iter, 3); % store f(x), norm-grad, alpha
    while k < max_iter
        % Compute search direction: p_k = -H_k * grad_f(x_k)
        p_k = -H_k * grad_f(x_k);

        % Compute step length using Wolfe line search
        alpha_k = wolfe_line_search(x_k, p_k, f, grad_f, alpha_init, options); %add1

        result(k+1, :) = [f(x_k), norm(grad_f(x_k)), alpha_k];
        % Update the iterate: x_{k+1} = x_k + alpha_k * p_k
        % Update iterate
        x_k1 = x_k + alpha_k * p_k;
        
        % Compute differences
        s_k = x_k1 - x_k;
        y_k = grad_f(x_k1) - grad_f(x_k);

        % Update inverse Hessian approximation using BFGS update
        if y_k' * s_k > epsilon_min * norm(y_k) * norm(s_k)
            rho_k = 1 / (y_k' * s_k);
            I = eye(n);
            H_k = (I - rho_k * (s_k * y_k')) * H_k * (I - rho_k * (y_k * s_k')) + rho_k * (s_k * s_k');
        end
        result(k+1, :) = [f(x_k), norm(grad_f(x_k)), alpha_k];
        % Update x_k
        x_k = x_k1;
        k = k + 1;

        % Check convergence
        if norm(grad_f(x_k)) < tol || computing_time > 600
            result(k+1, :) = [f(x_k), norm(grad_f(x_k)), alpha_k];
            break;
        end
        computing_time = toc(tic_time);
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