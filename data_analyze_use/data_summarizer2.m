% Set the folder path (current folder or specify another one)
folderPath = 'output/P12_Genhumps_5';  % e.g., './data'
outputFolder = './figures';  % or full path
filename1 = fullfile(outputFolder, 'P12_Genhumps_5_f.png');
filename2 = fullfile(outputFolder, 'P12_Genhumps_5_gf.png');

% Get list of all .mat files in the folder
matFiles = dir(fullfile(folderPath, '*.mat'));

% Prepare figures
figure(1); hold on; title('Fvalue vs iter.'); xlabel('Iteration No.'); ylabel('Fvalue');
figure(2); hold on; title('GradF vs iter.'); xlabel('Iteration No.'); ylabel('GradF');

% Loop through each file
for k = 1:length(matFiles)
    if mod(k, 2) == 1
        % Get the full file name
        fileName = fullfile(folderPath, matFiles(k).name);
        % Optionally display which file is being loaded
        fprintf('Loading file: %s\n', matFiles(k).name);
        
        % Load the .mat file
        data = load(fileName);
        data  = data.result;
    
        % X-axis is index (row number)
        x = (1:size(data, 1))';
    
        % Plot col1 vs col3
        figure(1);
        plot(x, data(:, 1), 'o-', 'DisplayName', matFiles(k).name);
    
        % Plot col2 vs col3
        figure(2);
        plot(x, data(:, 2), 'o-', 'DisplayName', matFiles(k).name);
    end
end
% Add legends
figure(1); legend('show', 'Interpreter', 'none');
grid on;
figure(2); legend('show', 'Interpreter', 'none');
grid on;
% Add grid

% Save figure as PNG

saveas(figure(1), filename1);
saveas(figure(2), filename2);
