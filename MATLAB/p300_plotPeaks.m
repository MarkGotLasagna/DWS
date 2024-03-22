%% To plot functions of maximum factors of columns (200) over rows (10000)
%
% This function is to be included in files such as 'main.m'
% to highlight transient peaks positions present in pictures taken by the line camera.
%

% 'region'      The region of the image to be cropped and plotted
function [] = p300_plotPeaks(filename, region, sigma)

    % 7100 - 7600 (500)
    V = tiffreadVolume(filename); % It is advised to put .tif in the same folder as the executable
    
    V_crop = V((region),:);
    V_crop = double(V_crop);

    V_crop_max = max(V_crop,[],2)'; % Andamento rumoroso

    V_crop_prctile = prctile(V_crop',99);
    V_crop_prctile1 = prctile(V_crop',1);
    



    % Typecast V_crop_prctile to double
    % V_crop_prctile = double(V_crop_prctile);

    V_crop_prctile = imgaussfilt(V_crop_prctile,sigma);
    V_crop_prctile1 = imgaussfilt(V_crop_prctile1,sigma);


    
    % V_crop(i) - V_crop_prctile1

    % % Number of columns in the matrix
    % num_cols = 5;
    % 
    % % Create the matrix with all columns equal to the given array
    % result_matrix = given_array.' * ones(1, num_cols);
    % 
    % disp('Resulting Matrix:')
    % disp(result_matrix)

    % V_norm = (V_crop - V_crop_prctile1) ./ (V_crop_prctile' - V_crop_prctile1'); % Problem: V_norm (0,1)
    V_norm = V_crop;

    sigma = 1;
    % Generate 1D Gaussian kernel
    kernelSize = ceil(3 * sigma) * 2 + 1; % Choose kernel size based on sigma
    gaussianKernel = fspecial('gaussian', [kernelSize, 1], sigma);
    
    % Perform Gaussian filtering on every vector along the first coordinate
    V_norm_smooth = conv2(V_norm, gaussianKernel, 'same'); % 'valid'?
    
    s = size(V_norm_smooth); % s = size(V_crop_max);

    avg_change(s(1) - 1) = 0; % avg_change = [];

    for i = 1:s(1) - 1
        change = single(V_norm_smooth(i + 1, :)) - single(V_norm_smooth(i, :));
        avg_change(i) = norm(change);
        % if i == Vsize(1) - blocks
        %     fprintf('Ciaone');
        % end
    end

    % Window size for the median filter
    windowSize = 21; % Adjust as needed
    
    % Apply the median filter using medfilt2
    filteredMatrix = medfilt2(avg_change, [1, windowSize]);
    
    % Convert the filtered matrix back to a vector
    filteredVector = filteredMatrix(:)';

    figure
    hold on
    subplot(1,2,1)
    imagesc(V_norm_smooth)
    subplot(1,2,2)
    plot(filteredVector,'b-');
    

end