% Set the folder path (current folder or specify another one)
folderPath = 'output/P12_Genhumps_5';  % e.g., './data'

% Get list of all .mat files in the folder
matFiles = dir(fullfile(folderPath, '*.mat'));

% Preallocate cell array for filenames and arrays for a, b, c
fileNames = strings(length(matFiles), 1);
optimal_vals = zeros(length(matFiles), 1);
grad_vals = zeros(length(matFiles), 1);
iter_vals = zeros(length(matFiles), 1);


% Loop through each file
for k = 1:length(matFiles)
    % Get the full file name
    fileName = fullfile(folderPath, matFiles(k).name);
    
    % Optionally display which file is being loaded
    fprintf('Loading file: %s\n', matFiles(k).name);
    
    % Load the .mat file
    data = load(fileName);
    
    result = data.result;
    fileNames(k) = matFiles(k).name;
    optimal_vals(k) = result(end, 1);
    grad_vals(k) = result(end, 2);
    iter_vals(k) = length(result);
end

% Create a table
summaryTable = table(fileNames, optimal_vals, grad_vals, iter_vals, ...
    'VariableNames', {'Filename', 'Optimal value', 'Gradient', 'Iterations'});

% Display the table
disp(summaryTable);