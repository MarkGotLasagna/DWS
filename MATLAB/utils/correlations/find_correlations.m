%% FIND_CORRELATIONS 
% Get correlations on locally normalized data
% Correlation is studied using different coefficients
% dom(coeff) = {'Pearson', 'Spearman', 'Kendall'}
function [Corr, Img] = find_correlations(filename, region, row_sigma, column_sigma, coeff)
    V = tiffreadVolume(filename); % It is advised to put .tif in the same folder as the executable
    if ischar(region) && region == "all"
        region = 1:max(size(V));
    end

    V_crop = double(V((region),:)); % Typecast V_crop to double
    perc_97 = prctile(V_crop, 97, 2);
    v_crop_97 = perc_97;
    perc_03 = prctile(V_crop, 3, 2);
    v_crop_03 = perc_03;

    %% filtering percentiles (only useful with norm or visual appearance)
    % v_crop_97 = imgaussfilt(perc_97, row_sigma);
    % v_crop_03 = imgaussfilt(perc_03, row_sigma);
    %% end
    
    V_norm = local_normalize(V_crop, v_crop_03, v_crop_97);

    V_smooth = gaussian_smooth(V_norm, column_sigma);
    % V_smooth = median_smooth(V_norm, column_sigma);
    % V_smooth = bilateral_smooth(V_norm, column_sigma);

    bins = 5;
    V_eq = histogram_equalization(V_smooth, bins);

    %% image processing pipeline
    figure
    subplot(1, 4, 1)
    imagesc(V);
    xlabel('pixels (px)');
    ylabel('time (t)');
    colormap(gray);
    colorbar;
    title("original",'Interpreter','latex');

    subplot(1, 4, 2)
    imagesc(V_norm);
    xlabel('pixels (px)');
    ylabel('time (t)');
    colormap(gray);
    colorbar;
    title("normalized",'Interpreter','latex');

    subplot(1, 4, 3)
    imagesc(V_smooth);
    xlabel('pixels (px)');
    ylabel('time (t)');
    colormap(gray);
    colorbar;
    title("smooth",'Interpreter','latex');

    subplot(1, 4, 4)
    imagesc(V_eq);
    xlabel('pixels (px)');
    ylabel('time (t)');
    colormap(gray);
    colorbar;
    title("equalized",'Interpreter','latex');

    sgtitle("image processing pipeline");
    %% end

    window_size = column_sigma*4+1; % time distance between rows
    correlations = coeff_correlation(V_eq, coeff, window_size);

    st = "#win_size: " + window_size + ", #col_sigma: " + column_sigma + ", #row_sigma: " + row_sigma;
    
    % figure('units','normalized','outerposition',[0 0 1 1])
    
    %% 3rd and 97th percentile for each row
    % figure
    % hold on
    % plot(v_crop_97, 'r-', "LineWidth", 1);
    % plot(v_crop_03, 'b-', "LineWidth", 1);
    % xlabel('time (t)','Interpreter','latex');
    % ylabel('Extreme values','Interpreter','latex');
    % title('3rd and 97th percentile for each row','Interpreter','none','VerticalAlignment','baseline');
    % legend('97prc', '3prc');
    % grid on;
    %%

    %% equalization comparison (5 bins vs 64 bins)
    % V_eq_64 = histogram_equalization(V_smooth, 64);
    % 
    % figure;
    % subplot(1, 2, 2)
    % imagesc(V_eq);
    % xlabel('pixels (px)');
    % ylabel('time (t)');
    % colormap(gray);
    % colorbar;
    % title(filename + " eq 5 bins",'Interpreter','latex');
    % 
    % subplot(1, 2, 1)
    % imagesc(V_eq_64);
    % xlabel('pixels (px)');
    % ylabel('time (t)');
    % colormap(gray);
    % colorbar;
    % title(filename + " eq 64 bins", 'Interpreter','latex');
    % sgtitle("equalization comparison (5 bins vs 64 bins)");
    %% end

    %% correlation post eq comparison (5 vs 64 bins vs no eq)
    % % V_eq_64 = histogram_equalization(V_smooth, 64);
    % correlations_64 = coeff_correlation(V_eq_64, coeff, window_size);
    % correlations_smooth = coeff_correlation(V_smooth, coeff, window_size);
    % 
    % figure;
    % plot(correlations,'b-');
    % hold on;
    % plot(correlations_64, 'r-');
    % plot(correlations_smooth, 'g-');
    % xlabel('time (t)','Interpreter','latex');
    % ylabel('Motion changes','Interpreter','latex');
    % title("correlation post eq comparison (5 vs 64 bins vs no eq)");
    % subtitle(st, 'Interpreter','none');
    % legend("5bins", "64bins", "no eq");
    % grid on;
    %%

    Corr = correlations;
    Img = V_eq;
end