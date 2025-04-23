fprintf('\nThe script is executed to examine unconstrained nonlinear optimization algorithms using a set of test problems, as listed below: \n');

fprintf('%-20s %-55s\n', 'Problem Name', 'Optimization Method');
fprintf('%-20s %-55s\n', '-------------', '-------------------');

fprintf('%-20s %s\n', '1:  quad_10_10',        '1: GradientDescent, with Armijo backtracking line search');
fprintf('%-20s %s\n', '2:  quad_10_1000',      '2: GradientDescentW, with Wolfe line search');
fprintf('%-20s %s\n', '3:  quad_1000_10',      '3: ModifiedNewton, with Armijo backtracking line search');
fprintf('%-20s %s\n', '4:  quad_1000_1000',    '4: ModifiedNewtonW, with Wolfe line search');
fprintf('%-20s %s\n', '5:  quartic_1',         '5: NewtonCG, with Armijo backtracking line search');
fprintf('%-20s %s\n', '6:  quartic_2',         '6: NewtonCGW, with Wolfe line search');
fprintf('%-20s %s\n', '7:  Rosenbrock_2',      '7: BFGS, BFGS quasi-Newton with Armijo backtracking line search');
fprintf('%-20s %s\n', '8:  Rosenbrock_100',    '8: BFGSW, BFGS quasi-Newton with Wolfe line search');
fprintf('%-20s %s\n', '9:  DataFit_2',         '9: DFP, DFP quasi-Newton with backtracking line search');
fprintf('%-20s %s\n', '10:  Expt_10',   '10: DFPW, DFP quasi-Newton with Wolfe line search');
fprintf('%-20s %s\n', '11:  Expt_1000', '11: LBFGS, L-BFGS quasi-Newton with Armijo backtracking line search');
fprintf('%-20s %s\n', '12:  Genhumps_5',       '12: LBFGSW, L-BFGS quasi-Newton with Wolfe line search');

prompt1 = "Please input the problem name (Input an integer: [1, 12]: \n";
problem_name = input(prompt1);

prompt2 = "Please input the problem name (Input an integer: [1, 12]: \n";
opt_method = input(prompt2);

[x,f] = solver(problem_name,opt_method,options);