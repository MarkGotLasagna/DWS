%% COEFF_PLOT_PEAKS  
% Plot locally normalized transient peaks 
% Correlation is studied using different coefficients
% dom(coeff) = {'Pearson', 'Spearman', 'Kendall'}
function [] = coeff_plot_peaks(filename, region, row_sigma, column_sigma, coeff)
    V = tiffreadVolume(filename); % It is advised to put .tif in the same folder as the executable
    if ischar(region) && region == "all"
        region = 1:max(size(V));
    end
    
    V_crop = double(V((region),:)); % Typecast V_crop to double
    v_crop_99 = imgaussfilt(prctile(V_crop, 99, 2), row_sigma);
    v_crop_01 = imgaussfilt(prctile(V_crop, 1, 2), row_sigma);

    V_norm = local_normalize(V_crop, v_crop_01, v_crop_99);

    % V_smooth = gaussian_smooth(V_norm, column_sigma);
    % V_smooth = median_smooth(V_norm, column_sigma);
    V_smooth = bilateral_smooth(V_norm, column_sigma);

    bins = 5;
    V_eq = histogram_equalization(V_smooth, bins);

    window_size = column_sigma*2+1; % time distance between rows
    % V_rmse = rmse_window(V_smooth, window_size);

    correlations = coeff_correlation(V_eq, coeff, window_size*2);

    % PLOTS SECTION 
    st = "#win_size: " + window_size + ", #col_sigma: " + column_sigma + ", #row_sigma: " + row_sigma;
    
    figure('units','normalized','outerposition',[0 0 1 1])
    
    % UNCOMMENT TO SEE 1st AND 99th PERCENTILE 
    % subplot(2, 2, 2)
    % hold on
    % plot(v_crop_99, 'r-');
    % plot(v_crop_01, 'b-');
    % xlabel('time (t)','Interpreter','latex');
    % ylabel('Extreme values','Interpreter','latex');
    % title(t,'Interpreter','none','VerticalAlignment','baseline');
    % legend('99prc', '1prc');
    % grid on;
    % hold off;

    subplot(1, 3, 1)
    imagesc(V_norm);
    xlabel('pixels (px)');
    ylabel('time (t)');
    colormap(gray);
    colorbar;
    title(filename + " pre eq",'Interpreter','latex');

    subplot(1, 3, 2)
    imagesc(V_smooth);
    xlabel('pixels (px)');
    ylabel('time (t)');
    colormap(gray);
    colorbar;
    title(filename + " post smooth (bilat), sigma=" + column_sigma,'Interpreter','latex');

    subplot(1, 3, 3)
    imagesc(V_eq);
    xlabel('pixels (px)');
    ylabel('time (t)');
    colormap(gray);
    colorbar;
    title(filename + " post eq, " + bins + " bins",'Interpreter','latex');

    figure;
    % subplot(2, 1, 1);
    plot(correlations,'b-');
    xlabel('time (t)','Interpreter','latex');
    ylabel('Motion changes','Interpreter','latex');
    title(filename);
    subtitle(st, 'Interpreter','none');
    legend(coeff + " coefficient");
    grid on;

    % UNCOMMENT TO SEE PIXELS INTENSITY CHANGE IN TIME
    % subplot(2, 1, 2);
    % hold on;
    % plot(V_eq(:, 1),'b-');
    % plot(V_eq(:, 2),'g-');
    % plot(V_eq(:, 3),'r-');
    % plot(V_eq(:, 4),'k-');
    % plot(V_eq(:, 5),'b--');
    % plot(V_eq(:, 6),'g--');
    % plot(V_eq(:, 7),'r--');
    % plot(V_eq(:, 8),'k--');
    % plot(V_eq(:, 9),'b:');
    % plot(V_eq(:, 10),'g:');
    % % plot(V_eq(:, 11),'r:');
    % % plot(V_eq(:, 12),'k:');
    % % plot(V_eq(:, 13),'b--');
    % % plot(V_eq(:, 14),'g--');
    % % plot(V_eq(:, 15),'r--');
    % % plot(V_eq(:, 16),'k--');
    % xlabel('time (t)','Interpreter','latex');
    % ylabel('pixels intensity','Interpreter','latex');
    % title(filename);
    % subtitle("#timesteps=" + region(1) + "-" + region(size(region, 2)), 'Interpreter','none');
    % legend("1", "2", "3", "4", "5", "6", "7", "8", "9", "10");
    % grid on;
end