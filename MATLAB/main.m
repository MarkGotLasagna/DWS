%% SHOW "supposedly" WHERE A TRANSIENT PEAK IS

addpath("utils\");
%addpath("utils\correlations\");

clear, clc, close all;

% The pictures to be loaded and processed using any of the methods provided
pics = ["PICS/Picture1.tif" "PICS/Picture2.tif" "PICS/Picture3.tif" ...
    "PICS/Picture4.tif" "PICS/Picture5.tif" "PICS/Picture6.tif"];

Im1 = 'PICS/NA.png'; 

row_sigma = 100; % high values to reduce noise
col_sigma = 5; 

for i = 1:length(pics)
    norm_plot_peaks(pics(i), 'all', row_sigma, col_sigma);
end