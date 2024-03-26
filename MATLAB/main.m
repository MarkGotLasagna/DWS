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

%% DEFAULT
figure('Name','plot_peaks.m','NumberTitle','off')

subplot(1,2,1)
plot_peaks(Pic1,10);
subplot(1,2,2)
plot_peaks(Pic2,10);

%% LOCAL NORMALIZE
figure('Name','ln_plot_peaks.m','NumberTitle','off')

subplot(1,2,1)
ln_plot_peaks(Pic1,10);
subplot(1,2,2)
ln_plot_peaks(Pic2,10);

%% P200
figure('Name','p200_plot_peaks.m','NumberTitle','off')

subplot(1,2,1)
p200_plot_peaks(Pic1,10);
subplot(1,2,2)
p200_plot_peaks(Pic2,10);

%% NORMALIZE
figure('Name','n_plot_peaks.m','NumberTitle','off')
n_plot_peaks(Pic1,1:10000, 20);

