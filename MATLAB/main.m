%% SHOW WHERE A TRANSIENT PEAK IS

addpath("utils\");
addpath("utils\correlations\");
addpath("utils\processing\");

clear, clc, close all;

% example pictures (some of them with no events)
pics = ["PICS/Picture1.tif" "PICS/Picture2.tif" "PICS/Picture3.tif" ...
    "PICS/Picture4.tif" "PICS/Picture5.tif" "PICS/Picture6.tif"];

%% Load sample from PASTA line camera data
% path = "path/to/PASTA_Linecamera_Data/";
% img = "0038_S101A2-02_R000_2_000111_20220702_080959_000000549.tif";
% img = "0038_S101A2-02_R000_2_000114_20220702_081001_000000549.tif";
% img = "0038_S101A2-02_R000_2_000108_20220702_080958_000000549.tif";
% img = "0038_S101A2-02_R000_2_000104_20220702_080957_000000549.tif";
% img = "0038_S101A2-02_R000_2_000103_20220702_080957_000000549.tif";
% img_name = path + img;
%% end

img_name = pics(6);

Im1 = 'PICS/NA.png'; 

row_sigma = 200; % high values to reduce noise
col_sigma = 1;

%% find correlations only in transition event
% find_correlations(pics(4), 8250:1:8450, row_sigma, col_sigma, "Kendall");
% find_correlations(pics(5), 5500:1:8500, row_sigma, col_sigma, "Kendall");
%% end

[correlations, image] = find_correlations(img_name, 'all', row_sigma, col_sigma, "Kendall");
figure;
plot(correlations, 'b-');
grid on;

%% correlation coefficient comparison
%[correlations2, image2] = find_correlations(img_name, 'all', row_sigma, col_sigma, "Pearson");
%hold on;
%plot(correlations2, 'r-');
%legend('Location','southeast');
%legend('kendall', 'pearson');
%% end

% threshold
l = 0.6;
hold on;
plot(l .* ones(length(correlations), 1), 'g--');
ylim([0 1]);

zones = find_zones(correlations, l);

if(size(zones) == [0 0])
    disp(['no event found. try to increase the threshold value or change correlation coefficient']);
    legend("data", "threshold");
    legend('Location','southeast');
    return;
end

[x_real, y] = find_peaks(correlations, zones);
for i=1:length(y)
    x = 0:1:size(y{i}, 1)-1;
    fun = @(a,b,c,x) b.*(1-c.*exp(-a.*x));
    fitfun = fittype( fun );
    f = fit(x', y{i}, fitfun, 'StartPoint', [0.5 0.5 0.5], 'Lower', [0 0 0], 'Upper', [100 1 1]);
    % hold on;
    coeffvals = coeffvalues(f);
    y_real = fun(coeffvals(1), coeffvals(2), coeffvals(3), x)';
    plot(cell2mat(x_real(i)), y_real, LineWidth=3);
    legend_info{i} = "a = " + coeffvals(1);
end
legend(["data" "threshold" legend_info]);
legend('Location','southeast');
sgtitle(img_name, "Interpreter", "none");
license("inuse");