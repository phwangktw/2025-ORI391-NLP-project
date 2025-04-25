function [x,f,computing_time,iterations] = solver(problem, method)

%add a folder
addpath('step_selector');
addpath('other_helper_funs');

        %update the function, gradient, and hessian based on user's choice
        switch problem
            case 1
                addpath('problem_set\P1_quad_10_10');
                rng(0); x0=20*rand(10,1)-10;

                Obj.func = @quad_10_10_func;
                Obj.grad = @quad_10_10_grad;
                Obj.hess = @quad_10_10_Hess;
            case 2
                addpath('problem_set\P2_quad_10_1000');
                rng(0); x0=20*rand(10,1)-10;

                Obj.func = @quad_10_1000_func;
                Obj.grad = @quad_10_1000_grad;
                Obj.hess = @quad_10_1000_Hess;
            case 3

                addpath('problem_set\P3_quad_1000_10');
                rng(0); x0=20*rand(1000,1)-10;

                Obj.func = @quad_1000_10_func;
                Obj.grad = @quad_1000_10_grad;
                Obj.hess = @quad_1000_10_Hess;
            case 4

                addpath('problem_set\P4_quad_1000_1000');
                rng(0); x0=20*rand(1000,1)-10;

                Obj.func = @quad_1000_1000_func;
                Obj.grad = @quad_1000_1000_grad;
                Obj.hess = @quad_1000_1000_Hess;
            case 5

                addpath('problem_set\P5_Quartic_1');
                x0=[cosd(70), sind(70), cosd(70), sind(70)]';

                Obj.func = @quartic_1_func;
                Obj.grad = @quartic_1_grad;
                Obj.hess = @quartic_1_Hess;
            case 6

                addpath('problem_set\P6_Quartic_2');
                x0=[cosd(70), sind(70), cosd(70), sind(70)]';

                Obj.func = @quartic_2_func;
                Obj.grad = @quartic_2_grad;
                Obj.hess = @quartic_2_Hess;
            case 7

                addpath('problem_set\P7_Rosenbrock_2');
                x0=[-1.2,1]';

                Obj.func = @rosenbrock_2_func;
                Obj.grad = @rosenbrock_2_grad;
                Obj.hess = @rosenbrock_2_Hess;
            case 8

                addpath('problem_set\P8_Rosenbrock_100');
                x0 = ones(100,1);
                x0(1,1) = -1.2;
                Obj.func = @rosenbrock_100_func;
                Obj.grad = @rosenbrock_100_grad;
                Obj.hess = @rosenbrock_100_Hess;
            case 9

                addpath('problem_set\P9_DataFit_2');
                x0=[1,1]';

                Obj.func = @DataFit_2_func;
                Obj.grad = @DataFit_2_grad;
                Obj.hess = @DataFit_2_Hess;
            case 10

                addpath('problem_set\P10_Exponential_10');
                x0 = zeros(10,1); x0(1,1) = 1;

                Obj.func = @Exponential_10_func;
                Obj.grad = @Exponential_10_grad;
                Obj.hess = @Exponential_10_Hess;
            case 11

                addpath('problem_set\P11_Exponential_1000');
                x0 = zeros(100,1); x0(1,1) = 1;

                Obj.func = @Exponential_1000_func;
                Obj.grad = @Exponential_1000_grad;
                Obj.hess = @Exponential_1000_Hess;
            case 12

                addpath('problem_set\P12_Genhumps_5');
                x0=[-506.2, 506.2, 506.2, 506.2, 506.2]';

                Obj.func = @genhumps_5_func;
                Obj.grad = @genhumps_5_grad;
                Obj.hess = @genhumps_5_Hess;

        end

        %update the method based on user's choice
        switch method

            case 1
                method = '01_gradient_descent';
                addpath('algorithm_set/GradientDescent');
                options = Initialize(method, problem);
                [sol, final_obj_value, iterations, status, computing_time] = gradientdescent(x0, Obj, options);
            case 2
                method = '02_gradient_descentW';
                addpath('algorithm_set/GradientDescent');
                options = Initialize(method, problem);
                [sol, final_obj_value, iterations, status, computing_time] = gradientdescentW(x0, Obj, options);
            case 3
                method = '03_modified_newton';  
                addpath('algorithm_set/ModifiedNewton');
                options = Initialize(method, problem);
                [sol, final_obj_value, iterations, status, computing_time] = modifiednewton(x0, Obj, options);
            case 4
                method = '04_modified_newtonW';  
                addpath('algorithm_set/ModifiedNewton');
                options = Initialize(method, problem);
                [sol, final_obj_value, iterations, status, computing_time] = modifiednewtonW(x0, Obj, options);
            case 5
                method = '05_newtonCG';  
                addpath('algorithm_set/NewtonCG');
                options = Initialize(method, problem);
                [sol, final_obj_value, iterations, status, computing_time] = newtonCG(x0, Obj, options);
            case 6
                method = '06_newtonCGW';  
                addpath('algorithm_set/NewtonCG');
                options = Initialize(method, problem);
                [sol, final_obj_value, iterations, status, computing_time] = newtonCGW(x0, Obj, options);
            case 7
                method = '07_BFGS';  
                addpath('algorithm_set/BFGS');
                options = Initialize(method, problem);
                [sol, final_obj_value, iterations, status, computing_time] = BFGS(x0, Obj, options);
            case 8
                method = '08_BFGSW';  
                addpath('algorithm_set/BFGS');
                options = Initialize(method, problem);
                [sol, final_obj_value, iterations, status, computing_time] = BFGSW(x0, Obj, options);
            case 9
                method = '09_DFP';  
                addpath('algorithm_set/DFP');
                options = Initialize(method, problem);
                [sol, final_obj_value, iterations, status, computing_time] = DFP(x0, Obj, options);
            case 10
                method = '10_DFPW';  
                addpath('algorithm_set/DFP');
                options = Initialize(method, problem);
                [sol, final_obj_value, iterations, status, computing_time] = DFPW(x0, Obj, options);
            case 11
                method = '11_LBFGS';  
                addpath('algorithm_set/LBFGS');
                options = Initialize(method, problem);
                [sol, final_obj_value, iterations, status, computing_time] = LBFGS(x0, Obj, options);
            case 12
                method = '12_LBFGSW'; 
                addpath('algorithm_set/LBFGS');
                options = Initialize(method, problem);
                [sol, final_obj_value, iterations, status, computing_time] = LBFGSW(x0, Obj, options);

        end
        
        %get the final result 
        x = sol; f = final_obj_value;
        fprintf('Solution: \n');
        disp(sol);
        fprintf('Final objective value: %f\n', final_obj_value);
        fprintf('Iterations: %d\n', iterations);
        fprintf('Computing time: %f seconds\n', computing_time);
        fprintf('Status: %s\n', status);
end