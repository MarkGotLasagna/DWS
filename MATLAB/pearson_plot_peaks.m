%% PEARSON_PLOT_PEAKS  
% Plot locally normalized transient peaks 
% Correlation is studied using Pearson correlation coefficient
function [] = pearson_plot_peaks(filename, region, row_sigma, column_sigma)
    V = tiffreadVolume(filename); % It is advised to put .tif in the same folder as the executable
    if ischar(region) && region == "all"
        region = 1:max(size(V));
    end
    
    V_crop = double(V((region),:)); % Typecast V_crop to double
    v_crop_99 = imgaussfilt(prctile(V_crop, 99, 2), row_sigma);
    v_crop_1 = imgaussfilt(prctile(V_crop, 1, 2), row_sigma);

    V_norm = local_normalize(V_crop, v_crop_1, v_crop_99);

    V_norm_smooth = column_smooth(V_norm, column_sigma);

    interval = 1; % time distance between rows
    correlations = coeff_correlation(V_norm_smooth, "Pearson", interval);

    % PLOTS SECTION 
    t = mfilename + ".m";
    st = "#interval: " + interval + ", #col_sigma: " + column_sigma + ", #row_sigma: " + row_sigma;
    
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(2, 2, [1 3]);
    imagesc(V_norm_smooth);
    xlabel('pixels (px)');
    ylabel('time (t)');
    colormap(gray);
    colorbar;
    title(["\textbf{Processed }", filename],'Interpreter','latex');

    subplot(2, 2, 2)
    hold on
    plot(v_crop_99, 'r-');
    plot(v_crop_1, 'b-');
    xlabel('time (t)','Interpreter','latex');
    ylabel('Extreme values','Interpreter','latex');
    title(t,'Interpreter','none','VerticalAlignment','baseline');
    legend('99prc', '1prc');
    grid on;
    hold off;

    subplot(2, 2, 4);
    plot(correlations,'b-');
    xlabel('time (t)','Interpreter','latex');
    ylabel('Motion changes','Interpreter','latex');
    subtitle(st, 'Interpreter','none');
    legend('Pearson correlation');
    grid on;
end