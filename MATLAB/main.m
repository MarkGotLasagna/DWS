%% SHOW WHERE A TRANSIENT PEAK IS

addpath("utils\");
addpath("utils\correlations\");
addpath("utils\processing\");

clear, clc, close all;

% The pictures to be loaded and processed using any of the methods provided
pics = ["PICS/Picture1.tif" "PICS/Picture2.tif" "PICS/Picture3.tif" ...
    "PICS/Picture4.tif" "PICS/Picture5.tif" "PICS/Picture6.tif"];

% Load sample from PASTA line camera data
path = "C:/Users/ongar/Pictures/PASTA_Linecamera_Data/";
% img = "0038_S101A2-02_R000_2_000103_20220702_080957_000000549.tif";
% img = "0038_S101A2-02_R000_2_000104_20220702_080957_000000549.tif";
% img = "0038_S101A2-02_R000_2_000108_20220702_080958_000000549.tif";
img = "0038_S101A2-02_R000_2_000111_20220702_080959_000000549.tif";
%%% img = "0038_S101A2-02_R000_2_000114_20220702_081001_000000549.tif";

img_name = path + img;

Im1 = 'PICS/NA.png'; 

row_sigma = 200; % high values to reduce noise
col_sigma = 1;

% coeff_plot_peaks(pics(4), 7500:1:9500, row_sigma, col_sigma, "Kendall");
% coeff_plot_peaks(pics(5), 5500:1:8500, row_sigma, col_sigma, "Kendall");

[correlations, image] = find_correlations(img_name, 'all', row_sigma, col_sigma, "Kendall");
plot(correlations);

l = 0.4;
zones = find_zones(correlations, l);

[x, y] = find_peaks(correlations, zones);

for i=1:length(y)
    figure;
    plot(x{i}, 1-y{i});
    f = fit(x{i},1-y{i},'exp2');
    hold on;
    plot(f);
    title(img + " - " + i, "Interpreter", "none");
end
