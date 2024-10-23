function [] = save_path(folder,bool)
%SAVE_PATH  Save folder to MATLAB's path.
%  Inlcude all folders and subfolder from specified path
%  to MATLAB's path. Use variable bool to either save the 
%  path for future sessions (1), or don't save (other).
%
%  INPUTS
%    (folder) - The folder to save into path variable
%    (bool)   - 1 to save, other to not save
%  OUTPUTS
%    (/)
%
%  Examples
%    % Inlcude path and save for future MATLAB sessions
%    save_path("C:\Users\march\Documents\MyMATLABProj", 1);

addpath(genpath(folder));

if (bool == 1)
    savepath
else
    return
end

end