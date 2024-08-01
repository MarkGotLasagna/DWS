%% SHOW WHERE A TRANSIENT PEAK IS

addpath("utils\");
addpath("utils\correlations\");
addpath("utils\processing\");

clear, clc, close all;

% The pictures to be loaded and processed using any of the methods provided
pics = ["PICS/Picture1.tif" "PICS/Picture2.tif" "PICS/Picture3.tif" ...
    "PICS/Picture4.tif" "PICS/Picture5.tif" "PICS/Picture6.tif"];

% Load sample from PASTA line camera data
% 
% img = "0038_S101A2-02_R000_2_000103_20220702_080957_000000549.tif";
% img = "0038_S101A2-02_R000_2_000104_20220702_080957_000000549.tif";
% img = "0038_S101A2-02_R000_2_000108_20220702_080958_000000549.tif";
 img = "0038_S101A2-02_R000_2_000111_20220702_080959_000000549.tif";
path = "C:/Users/ongar/Pictures/PASTA_Linecamera_Data/";
% img = "0038_S101A2-02_R000_2_000114_20220702_081001_000000549.tif";

img_name = path + img;

Im1 = 'PICS/NA.png'; 

row_sigma = 200; % high values to reduce noise
col_sigma = 1;

% find_correlations(pics(4), 7500:1:9500, row_sigma, col_sigma, "Kendall");
% find_correlations(pics(5), 5500:1:8500, row_sigma, col_sigma, "Kendall");

[correlations, image] = find_correlations(img_name, 'all', row_sigma, col_sigma, "Kendall");
plot(correlations); % data.jpeg
grid on;

l = 0.6;
zones = find_zones(correlations, l);

[x_real, y] = find_peaks(correlations, zones);

for i=1:length(y)
    x = 0:1:size(y{i}, 1)-1;
    fun = @(a,b,c,x) b.*(1-c.*exp(-a.*x));
    fitfun = fittype( fun );
    f = fit(x', y{i}, fitfun, 'StartPoint', [5 0.5 0.5], 'Lower', [0 0 0], 'Upper', [100 1 1]);
    hold on;
    coeffvals = coeffvalues(f);
    y_real = fun(coeffvals(1), coeffvals(2), coeffvals(3), x)';
    plot(cell2mat(x_real(i)), y_real, LineWidth=3);
    legend_info{i} = "a = " + coeffvals(1);
end
legend(["data" legend_info]);
legend('Location','southeast')
title(img, "Interpreter", "none");