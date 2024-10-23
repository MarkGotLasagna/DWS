function PICS = load_pics(folder)
%LOAD_PICS - Load (tif) data files from directory.
%  This helper function will load any picture of tif format, from 
%  any folder, inside a cell array. The folder's path can be 
%  either relative or full.
%  
%  INPUTS
%    (folder) - The folder's path
%  OUTPUTS
%    (PICS) - Cell array variable containing pictures
%
%  Examples
%    % Save some pictures into cell array
%    PICS = load_pics("C:\Users\march\Pictures\MtTifs");
%    % Save one picture from cell array into variable for later use
%    picture1 = PICS{1}; % Note: use curly brakets

% Save files info into structure
struct = dir(fullfile(folder, "*.tif"));

% Create a cell array of length equal to the size of structure
PICS = cell(1, length(struct));

% For every element inside data structure,
% save their name inside cell array
for i = 1:length(struct)
    path = fullfile(folder, struct(i).name);
    PICS{i} = imread(path);
end

end