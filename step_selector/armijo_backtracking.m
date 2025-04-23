function alpha = armijo_backtracking(xk, fk, gradk, pk, alpha_init, obj_func, options)
% ArmijoBacktracking computes the step length parameter alpha

    %Input parameters
    c1 = options.c1;
    tau = options.tau;
    % Initialize alpha with alpha_init
    alpha = alpha_init;
    
    % Compute the initial objective function value if not provided
    if isempty(fk)
        fk = feval(obj_func, xk);
    end

    % Compute the value of the objective function at the new point
    f_new = feval(obj_func, xk + alpha * pk);
    
    % Armijo condition
    while f_new > fk + c1 * alpha * gradk' * pk
        alpha = tau * alpha;
        % Recompute the value of the objective function at the new point
        f_new = feval(obj_func, xk + alpha * pk);
    end
end