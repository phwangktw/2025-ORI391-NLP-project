%% Modified Newton method  with Armijo Backtracking
function [x, f_val, iter, status, computing_time] = modifiednewton(x0, Obj, options)
    x = x0;
    f = Obj.func;
    grad_f = Obj.grad;
    f_hess = Obj.hess;
    alpha_init = options.alpha_init;
    max_iter = options.max_iters;
    tol = options.tol;
    file_name = fullfile(options.outputpath, options.file_name+".mat");

    iter = 1;
    norm_g = 10.^100; %init norm
    beta = 1e-4;
    result = zeros(max_iter, 4); % store f(x), norm-grad, alpha, delta
    alpha = alpha_init;
    tic_time = tic;
    computing_time = 0;
    while norm_g > tol && iter < max_iter
        g = grad_f(x);
        H = f_hess(x);     % Compute Hessian
        [Bk, delta] = cholesky_hessian_correction(H, beta); % Compute modified-Hessian
        pk = -Bk\g;       % Solve Bk * p = -g
        norm_g = norm(g);
        result(iter, :) = [f(x), norm(grad_f(x)), alpha, delta];
        % Compute step length using Wolfe line search
        alpha = wolfe_line_search(x, pk, f, grad_f, alpha_init, options); %add2
        x_k_prev = x;
        x = x + alpha * pk;  % Update rule
        % Update alph_init for the next iteration
        alpha_init = update_armijo_step(f, x, x_k_prev, g, pk);
        iter = iter + 1;
    end

    %% Execution loop is DONE above, now do the basic parsing

    result = result(1:iter-1, :);
    save(file_name, 'result');
    f_val = f(x);  % Compute function value at optimal x

    % Computing time
     computing_time = toc(tic_time);

    % Check the reason for stopping the iterations
    if norm(g) <= tol
        status = 'optimal solution found';
    elseif computing_time>=600
        status = 'maximum computing time reached';
    else
        status = 'maximum iterations reached';
    end
end