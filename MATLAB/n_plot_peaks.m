% N_PLOT_PEAKS  Plot locally normalized percentiles peaks
function [] = n_plot_peaks(filename, region, image_sigma, column_sigma)
    V = tiffreadVolume(filename); % It is advised to put .tif in the same folder as the executable
    
    if ischar(region) && region == "all"
        region = 1:max(size(V));
    end

    V_crop = V((region),:);

    % Typecast V_crop to double
    V_crop = double(V_crop);

    % Too much noise
    % V_crop_max = max(V_crop,[],2)'; 

    V_crop_99 = prctile(V_crop',99)';
    V_crop_1 = prctile(V_crop',1)';

    V_crop_99 = imgaussfilt(V_crop_99,image_sigma);
    V_crop_1 = imgaussfilt(V_crop_1,image_sigma);


    %%LOCAL NORMALIZING PROCESS: 
    % x = (x - x_min) / (x_max - x_min);

    % Create the matrix with all columns equal to the given array
    [~, num_cols] = size(V_crop);
    V_crop_1 = V_crop_1 * ones(num_cols, 1)';
    
    % Subtract 1st percentile (x_min)
    V_norm = V_crop - V_crop_1;
    
    % Divide by the difference between
    % 99th percentile and 1st percentile (x_max - x_min)
    V_norm = V_norm ./ (V_crop_99 - V_crop_1);


    %%SMOOTHING PROCESS:
    % Gaussian smoothing on every columns +
    % median smoothing on average change (to mantain motion shapes)

    % Generate 1D Gaussian kernel
    kernel_size = ceil(3 * column_sigma) * 2 + 1; % Choose kernel size based on column sigma
    gaussian_kernel = fspecial('gaussian', [kernel_size, 1], column_sigma);
    
    % Perform Gaussian filtering on every vector along the first coordinate
    V_norm_smooth = conv2(V_norm, gaussian_kernel, 'same'); % 'valid'?

    blocks = 1;
    s = size(V_norm_smooth);
    avg_change(s(1) - blocks) = 0; % avg_change = [];

    % Find average change for each subsequent row
    for i = 1:s(1) - blocks
        change = V_norm_smooth(i + blocks, :) - V_norm_smooth(i, :);
        avg_change(i) = norm(change);
    end

    % ???
    % Window size for the median filter
    window_size = 21; % Adjust as needed
    
    % Apply the median filter using medfilt2
    avg_filtered_matrix = medfilt2(avg_change, [1, window_size]);
    
    % Convert the filtered matrix back to a vector
    avg_filtered_vector = avg_filtered_matrix(:)';

    t = mfilename + ".m";
    st = "#blocks: " + blocks + ", #col_sigma: " + column_sigma;
    
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(1, 2, 1);
    imagesc(V_norm_smooth);
    xlabel('pixels (px)');
    ylabel('time (t)');
    colormap(gray);
    colorbar;
    title(["\textbf{Processed }", filename],'Interpreter','latex');

    subplot(1, 2, 2);
    plot(avg_filtered_vector,'b-');
    ylim([0 1]);
    xlabel('time (t)','Interpreter','latex');
    ylabel('Motion changes','Interpreter','latex');
    title(t,'Interpreter','none','VerticalAlignment','baseline');
    subtitle(st, 'Interpreter','none');
    legend('Normalized avg\_change');
    grid on;
end