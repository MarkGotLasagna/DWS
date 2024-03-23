%% To plot functions of maximum factors of columns (200) over rows (10000)
%
% This function is to be included in files such as 'main.m'
% to highlight transient peaks positions present in pictures taken by the line camera.
%

% 'region'      The region of the image to be cropped and plotted
function [] = n_plotPeaks(filename, region, sigma)
    V = tiffreadVolume(filename); % It is advised to put .tif in the same folder as the executable
    
    V_crop = V((region),:);

    % Typecast V_crop to double
    V_crop = double(V_crop);

    % Too much noise
    % V_crop_max = max(V_crop,[],2)'; 

    V_crop_prctile = prctile(V_crop',99)';
    V_crop_prctile1 = prctile(V_crop',1)';

    V_crop_prctile = imgaussfilt(V_crop_prctile,sigma);
    V_crop_prctile1 = imgaussfilt(V_crop_prctile1,sigma);


    %%LOCAL NORMALIZING PROCESS: 
    % x = (x - x_min) / (x_max - x_min);

    % Create the matrix with all columns equal to the given array
    [num_rows, num_cols] = size(V_crop);
    V_crop_prctile1 = V_crop_prctile1 * ones(num_cols, 1)';
    
    % Subtract 1st percentile (x_min)
    V_norm = V_crop - V_crop_prctile1;
    
    % Divide by the difference between
    % 99th percentile and 1st percentile (x_max - x_min)
    V_norm = V_norm ./ (V_crop_prctile - V_crop_prctile1);


    %%SMOOTHING PROCESS:
    % Gaussian smoothing on every columns +
    % median smoothing on average change (to mantain motion shapes)

    % Generate 1D Gaussian kernel
    sigma = 1;
    kernel_size = ceil(3 * sigma) * 2 + 1; % Choose kernel size based on sigma
    gaussian_kernel = fspecial('gaussian', [kernel_size, 1], sigma);
    
    % Perform Gaussian filtering on every vector along the first coordinate
    V_norm_smooth = conv2(V_norm, gaussian_kernel, 'same'); % 'valid'?

    blocks = 1; % Try different values to see "avg_change" noise variation
    s = size(V_norm_smooth);
    avg_change(s(1) - blocks) = 0; % avg_change = [];

    % Find average change for each subsequent row
    for i = 1:s(1) - blocks
        change = V_norm_smooth(i + blocks, :) - V_norm_smooth(i, :);
        avg_change(i) = norm(change);
    end

    % Window size for the median filter
    window_size = 21; % Adjust as needed
    
    % Apply the median filter using medfilt2
    avg_filtered_matrix = medfilt2(avg_change, [1, window_size]);
    
    % Convert the filtered matrix back to a vector
    avg_filtered_vector = avg_filtered_matrix(:)';

    subplot(1,2,2)
    plot(avg_filtered_vector,'b-');
    ylim([0 1]);
    xlabel('time');
    ylabel('change of motion');
    title(["\textbf{Normalized Transient Peaks from }", filename],'Interpreter','latex')
    subtitle(["Using blocks of size ", blocks], 'Interpreter','latex')
    legend('normalized avg_change')
    grid on

    subplot(1,2,1)
    imagesc(V_norm_smooth)
    xlabel('pixels');
    ylabel('time');
    colormap(gray);
    colorbar;
    title(["\textbf{Original image }", filename],'Interpreter','latex')
    subtitle("Using default color scale", 'Interpreter','latex')
end