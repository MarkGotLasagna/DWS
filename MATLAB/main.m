%% SHOW "supposedly" WHERE A TRANSIENT PEAK IS
%
% To execute all versions       'F5'
% To execute single sections    'Ctrl+ENTER'

clear, clc, close all;

% The pictures to be loaded and processed using any of the methods provided
pics = ["PICS/Picture1.tif" "PICS/Picture2.tif" "PICS/Picture3.tif" ...
    "PICS/Picture4.tif" "PICS/Picture5.tif" "PICS/Picture6.tif"];

Im1 = 'PICS/NA.png'; 

% Dalpa method
image_sigma = 100; % high values

% for i = [1, 2, 3, 4, 5, 10, 15, 20]
%     n_plot_peaks(pic,'all', image_sigma, i); 
% end

n_plot_peaks(pics(1), 'all', image_sigma, 5);

plot_peaks(pics(1), 'all', 1);
