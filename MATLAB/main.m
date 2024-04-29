%% SHOW "supposedly" WHERE A TRANSIENT PEAK IS
%
% To execute all versions       'F5'
% To execute single sections    'Ctrl+ENTER'

clear, clc, close all;

% The pictures to be loaded and processed using any of the methods provided
Pic1 = 'PICS/Picture1.tif'; Pic2 = 'PICS/Picture2.tif'; Pic3 = 'PICS/Picture3.tif';
Pic4 = 'PICS/Picture4.tif'; Pic5 = 'PICS/Picture5.tif'; Pic6 = 'PICS/Picture6.tif';
Im1 = 'PICS/NA.png'; 

pic = Pic6;
% Dalpa method
image_sigma = 20;
for i = [1, 2, 3, 4, 5, 10, 15, 20]
    n_plot_peaks(pic,'all', image_sigma, i); 
end