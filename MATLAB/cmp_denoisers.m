%% COMPARE CLASSICAL DENOISERS METHODS FOUND IN MATLAB
% Each plotted graph corresponds to a different denoising method used, not
% all denoisers are equal. The one best suitable depends entirely on the
% data that is parsed by the denoiser

% Pictures to be analyzed
Pics = ["PICS/Picture1.tif" "PICS/Picture2.tif" "PICS/Picture3.tif" ...
        "PICS/Picture4.tif" "PICS/Picture5.tif" "PICS/Picture6.tif"];

% The Gaussian Sigma (CHANGE ACCORDINGLY)
% Used when reducing noise of highs and lows
gsigma = 20;

% Read the picture and store it to matrix
V = tiffreadVolume(Pics(6));

% Typecast to double
% We do this to prevent problems with following calculations being 
% not compatible with data types 'uint8'
V = double(V);

% Get 99%highs and 1%lows
% We want to local normalize data, we take the highs and lows so that the
% resulting norm is not too much noisy. We then apply a Gaussian filter to
% these vectors to reduce noise even further.
v_99 = imgaussfilt(prctile(V, 99, 2), gsigma);
v_01 = imgaussfilt(prctile(V, 01, 2), gsigma);

% Local normalization process
% To compute the local normalization we first create a matrix with all
% columns equal to the 1%lows column vector.
[~, columns] = size(V);
V_01 = v_01 * ones(columns, 1)';
V_norm = (V - V_01) ./ (V_99 - V_01); % x = (x - x_min) / (x_max - x_min);

% 1D Gaussian kernel Sigma (CHANGE ACCORDINGLY)
ksigma = 5;

% Smoothing process
kernel_size = ceil(3 * ksigma) * 2 + 1;



