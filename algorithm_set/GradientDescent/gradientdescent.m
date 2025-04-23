%% Steepest Descent with Armijo Backtracking
% Author: POHAN WANG (Spring-2025, UT-Austin)
function [x, f_val, iter, status, computing_time] = gradientdescent(x0, Obj, options)
    % alpha_init, beta, c, tol, max_iter, file_name
    x = x0;
    f = Obj.func;
    grad_f = Obj.grad;
    alpha_init = options.alpha_init;
    max_iter = options.max_iters;
    tol = options.tol;
    file_name = fullfile(options.outputpath, options.file_name+".mat");

    iter = 1;
    norm_g = 10.^100; %init norm
    result = zeros(max_iter, 3); % store f(x), norm-grad, alpha
    alpha = alpha_init;
    tic_time = tic;
    computing_time = 0;
    while norm_g > tol && iter < max_iter && computing_time < 600
        g = grad_f(x);
        pk = -g; %steepest descent
        norm_g = norm(g);
        result(iter, :) = [f(x), norm(grad_f(x)), alpha];
        alpha = armijo_backtracking(x, f(x), g, pk, alpha_init, f, options);  % Compute step size
        x_k_prev = x;
        x = x + alpha * pk;  % Update rule
        alpha_init = update_armijo_step(f, x, x_k_prev, g, pk);
        iter = iter + 1;
        computing_time = toc(tic_time);
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


