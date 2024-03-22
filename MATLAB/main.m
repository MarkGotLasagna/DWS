%% SHOW "supposedly" WHERE A TRANSIENT PEAK IS
%
% To execute all versions    'F5'
% To execute single methods  'Ctrl+ENTER'

clear, clc, hold off, close all;

Pic1 = 'PICS/Picture5.tif';
Pic2 = 'PICS/Picture6.tif';
Im1 = 'PICS/NA.png';
Im2 = 'PICS/NA.png';

%% Default version
figure('Name','plotPeaks.m','NumberTitle','off')

subplot(1,2,1)
plotPeaks(Pic1,10);
subplot(1,2,2)
plotPeaks(Pic2,10);
% plotPics(Im1,[.37 .59 .5 .3]);
% plotPics(Im2,[-.069 .59 .5 .3]);

%% Locally normalized version
figure('Name','ln_plotPeaks.m','NumberTitle','off')

subplot(1,2,1)
ln_plotPeaks(Pic1,10);
subplot(1,2,2)
ln_plotPeaks(Pic2,10);
% plotPics(Im1,[.37 .59 .5 .3]);
% plotPics(Im2,[-.069 .59 .5 .3]);

%% p200 version
figure('Name','p200_plotPeaks.m','NumberTitle','off')

subplot(1,2,1)
p200_plotPeaks(Pic1,10);
subplot(1,2,2)
p200_plotPeaks(Pic2,10);
% plotPics(Im1,[.37 .59 .5 .3]);
% plotPics(Im2,[-.069 .59 .5 .3]);

%% TESTING GROUNDS
figure('Name','TEST','NumberTitle','off')

% p300_plotPeaks(Pic1,7101:7600, 20);
p300_plotPeaks(Pic2,1:10000, 20);

%% NORMALIZE
figure('Name','normalize - Pic1','NumberTitle','off')
% event in [7100:7600]
normalize(Pic1,1:10000, 20);

figure('Name','normalize - Pic2','NumberTitle','off')
normalize(Pic2,1:10000, 20);