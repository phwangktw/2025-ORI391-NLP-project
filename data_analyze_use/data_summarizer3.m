% Preallocate storage
results = table();

% Loop over all combinations of prompt1 and prompt2 from 1 to 12
for prompt1 = 12:12
    for prompt2 = 1:12
        % Optionally display the current combination
        fprintf('Running combination: Problem = %d, Method = %d\n', prompt1, prompt2);
        problem_name = prompt1;
        opt_method = prompt2;
        [x,f,computing_time,iterations] = solver(problem_name,opt_method);

        % Append to results table
        results = [results; table(prompt1, prompt2, computing_time, iterations)];
    end
end

% Display the results
disp(results);