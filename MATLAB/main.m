%% SHOW "supposedly" WHERE A TRANSIENT PEAK IS
%
% To execute all versions       'F5'
% To execute single sections    'Ctrl+ENTER'

clear, clc, hold off, close all;

% The pictures to be loaded and processed using any of the methods provided
Pic1 = 'PICS/Picture1.tif'; Pic2 = 'PICS/Picture2.tif'; Pic3 = 'PICS/Picture3.tif';
Pic4 = 'PICS/Picture4.tif'; Pic5 = 'PICS/Picture5.tif'; Pic6 = 'PICS/Picture6.tif';

% The cropped pictures which purpose is to show where the transient peaks are
% see function 'plot_pics.m' for more details and use cases
Im1 = 'PICS/NA.png';    Im2 = 'PICS/NA.png';

figure('Name',Pic1,'NumberTitle','off')

%% DEFAULT
subplot(2,2,1)
plot_peaks(Pic1,'all',10);

%% LOCAL NORMALIZE
subplot(2,2,2)
ln_plot_peaks(Pic1,'all',10);

%% P200
subplot(2,2,3)
p200_plot_peaks(Pic1,'all',10);

%% NORMALIZE
subplot(2,2,4)
n_plot_peaks(Pic1,'all', 20);