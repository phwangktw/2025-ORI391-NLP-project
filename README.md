## 2025 Spring – UT Austin ORI391: Nonlinear Programming

This project implements **12 optimization algorithms**, combining **6 core methods** with two types of **step length strategies** (Armijo backtracking and Wolfe line search).

### Implemented Algorithms

Each base method is paired with a step size strategy, resulting in the following 12 algorithm variants:

1. Gradient Descent + Armijo backtracking  
2. Gradient Descent + Wolfe line search  
3. Modified Newton + Armijo backtracking  
4. Modified Newton + Wolfe line search  
5. Newton-CG + Armijo backtracking  
6. Newton-CG + Wolfe line search  
7. BFGS (quasi-Newton) + Armijo backtracking  
8. BFGS (quasi-Newton) + Wolfe line search  
9. DFP (quasi-Newton) + Armijo backtracking  
10. DFP (quasi-Newton) + Wolfe line search  
11. L-BFGS (quasi-Newton) + Armijo backtracking  
12. L-BFGS (quasi-Newton) + Wolfe line search  

---

### Test Problem Instances

We provide **12 different test problems** as benchmarks. Details for each can be found in `ProblemStatement.pdf`.

1. P1: quad_10_10  
2. P2: quad_10_1000  
3. P3: quad_1000_10  
4. P4: quad_1000_1000  
5. P5: quartic_1  
6. P6: quartic_2  
7. P7: Rosenbrock_2  
8. P8: Rosenbrock_100  
9. P9: DataFit_2  
10. P10: Exponential_10  
11. P11: Exponential_1000  
12. P12: Genhumps_5  

---

## User Manual

To run the experiments:

1. Open MATLAB and navigate to the project folder.
2. Run the `main.m` script.
3. When prompted, enter:
   - A problem number (1–12) corresponding to one of the test instances.
   - An algorithm number (1–12) corresponding to one of the methods listed above.

Example input:
```matlab
>> main
Enter problem number (1–12): 3
Enter algorithm number (1–12): 7
