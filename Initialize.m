function options = Initialize(method, problem)
   % Set alg parameters for all methods
    options.alpha_init =1;
    options.c1 = 10^-4;
    options.c2 = 0.9;
    options.tau = 0.5;
    options.max_iters = 1e+3;
    options.tol = 1e-6;
    options.beta = 1e-4;
    options.eta = 0.01;
    options.gamma = 1;
    options.epsilon_min = 10^-8; % BFGS and L-BFGS
    options.m = 10; %LBFGS memory size
    
    options.file_name = method;
  % file path
    switch problem
        case 1
            options.outputpath = 'output\P1_quad_10_10';
        case 2
            options.outputpath = 'output\P2_quad_10_1000';
        case 3
            options.outputpath = 'output\P3_quad_1000_10';
        case 4
            options.outputpath = 'output\P4_quad_1000_1000';
        case 5
            options.outputpath = 'output\P5_Quartic_1';
        case 6
            options.outputpath = 'output\P6_Quartic_2';
        case 7
            options.outputpath = 'output\P7_Rosenbrock_2';
        case 8
            options.outputpath = 'output\P8_Rosenbrock_100';
        case 9
            options.outputpath = 'output\P9_DataFit_2';
        case 10
            options.outputpath = 'output\P10_Exponential_10';
        case 11
            options.outputpath = 'output\P11_Exponential_1000';
        case 12
            options.outputpath = 'output\P12_Genhumps_5';
    end
end


