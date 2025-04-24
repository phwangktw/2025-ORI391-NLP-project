function [x_k, f_val, iter, status, computing_time] = DFPW(x0, Obj, options)

    
    tic_time = tic; % Start measuring computing time
    n = length(x0);
    H = eye(n); 
    % Extract parameters from options
    alpha_init = options.alpha_init;
    epsilon_min = options.epsilon_min;
    max_iter = options.max_iters;
    tol = options.tol;
    % Initial objective function and gradient evaluation
    f_obj = Obj.func(x0);
    f_grad = Obj.grad(x0);
    grad_norm_0 = norm(f_grad);
    grad_norm = grad_norm_0;
    iter = 0;

    file_name = fullfile(options.outputpath, options.file_name+".mat");
    result = zeros(max_iter, 3); % store f(x), norm-grad, alpha
    x_k = x0;
    computing_time = 0;
    % Main loop for DFP method
    while grad_norm > tol && iter < max_iter && computing_time < 600
        % Calculate search direction (DFP Method)
        p_k = -H*f_grad;
        % Line search to satisfy the Wolfe condition
        alpha_k = wolfe_line_search(x_k, p_k, Obj.func, Obj.grad, alpha_init, options); %add1
        result(iter+1, :) = [Obj.func(x_k), norm(Obj.grad(x_k)), alpha_k];
        % Update the position
        x_new = x_k + alpha_k * p_k;
        s = x_new - x_k;
        x_k = x_new;
        % Update objective function and gradient
        f_obj_new = Obj.func(x_k);
        f_grad_new = Obj.grad(x_k);
        y = f_grad_new - f_grad;
        % Update gradient norm and Hessian approximation
        grad_norm = norm(f_grad_new);
        if (y' * s) > epsilon_min * norm(y) * norm(s)
       
            H = H - (H*y*y'*H)/(y'*H*y) + (s*s')/(y'*s);
        end
        % Update  function and gradient
        f_obj = f_obj_new;
        f_grad = f_grad_new;
        % Increase iteration counter
        iter = iter + 1;
        computing_time = toc(tic_time);
    end

    %% Execution loop is DONE above, now do the basic parsing
    result = result(1:iter-1, :);
    save(file_name, 'result');
    f_val = Obj.func(x_k);  % Compute function value at optimal x

    % Computing time
     computing_time = toc(tic_time);

    % Check the reason for stopping the iterations
    if norm(Obj.grad(x_k)) <= tol
        status = 'optimal solution found';
    elseif computing_time>=600
        status = 'maximum computing time reached';
    else
        status = 'maximum iterations reached';
    end
end