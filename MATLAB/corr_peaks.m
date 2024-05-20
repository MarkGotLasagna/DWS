% CORR_PEAKS    Compute the correlation of rows
%   corr_peaks (picture, region, r_sigma, c_sigma, corr_type, interval) 
%   function computes the correlation between rows in a gray colored picture coming from a line camera.
%   PICTURE is the original picture provided in relative path, REGION is
%   the region of the picture to be used, R_SIGMA the Gaussian sigma to be
%   applied on REGION matrix, C_SIGMA the Gaussian sigma to be applied on
%   columns only, CORR_TYPE the type of correlation, INTERVAL the window
%   size for computing the correlation.
%
% Examples:
%   [V_crop, V_norm, V_smooth, v_corr] = CORR_PEAKS('Picture1.tif', 'all', 5, 5, 'Pearson', 1)
%   figure, imagesc(V_smooth);
%   figure, plot(v_corr);
function [V_crop, V_norm, V_smooth, v_corr] = ...
    corr_peaks (picture, region, r_sigma, c_sigma, corr_type, interval)
   
    % Check if the picture should be taken as a whole
    V = tiffreadVolume(picture);
    if ischar(region) && region == "all"
        region = 1:max(size(V));
    end

    % (1) FIRST ORDER GAUSSIAN FILTERING
    % Perform Gaussian filtering on 99%highs and 01%lows rows
    V_crop = double(V((region), :));
    v_01 = imgaussfilt(prctile(V_crop, 01, 2), r_sigma);
    v_99 = imgaussfilt(prctile(V_crop, 99, 2), r_sigma);

    % (2) NORMALIZATION
    % Data is normalized and clipped in ranges [0, 1] using Gaussian
    % filtered vectors containing 99%highs and 01%lows
    V_norm = local_normalize(V_crop, v_01, v_99);

    % (3) SECOND ORDER GAUSSIAN FILTERING
    % Filtering is done on columns exclusively using a custom kernel
    V_smooth = column_smooth(V_norm, c_sigma);

    % CORRELATION
    % Correlation between rows is computed using either one of the three
    % available methods provided by the function corr()
    v_corr = coeff_correlation(V_smooth, corr_type, interval);

    % PLOT IMAGES
    % Plot the resulting picture after each critical step
    % (1)
    % figure('name', 'Compare original with steps',...
    %     'numbertitle', 'off')
    % subplot(1, 3, 1)
    % colormap("gray")
    % imagesc(V), title('Original'), colorbar, grid on
    % % (2)
    % subplot(1, 3, 2)
    % imagesc(V_norm), title('Locally normalized'), colorbar, grid on
    % % (3)
    % subplot(1, 3, 3)
    % imagesc(V_smooth), title('Filtered on columns'), colorbar, grid on
    % 
    % % PLOT CORRELATION VECTOR
    % figure('Name', 'Correlation in a specified window', 'NumberTitle', 'off')
    % plot(v_corr);
    % grid on
    % title(["Correlation vector using ", corr_type]);
    % subtitle('0 not correlated, 1 strongly correlated');
end