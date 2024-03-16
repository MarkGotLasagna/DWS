%% SHOW "supposedly" WHERE A TRANSIENT PEAK IS
%
% To execute all versions    'F5'
% To execute single methods  'Ctrl+ENTER'

clear, clc, hold off, close all;

%% DEFAULT
figure('Name','Default')

subplot(1,2,1)
plotPeaks('PICS/Picture1.tif',10);
subplot(1,2,2)
plotPeaks('PICS/Picture2.tif',10);
plotPics('PICS/NA.png',[.37 .59 .5 .3]);
plotPics('PICS/NA.png',[-.069 .59 .5 .3]);

%% LN version
figure('Name','LN version')

subplot(1,2,1)
ln_plotPeaks('PICS/Picture1.tif',10);
subplot(1,2,2)
ln_plotPeaks('PICS/Picture2.tif',10);
plotPics('PICS/NA.png',[.37 .59 .5 .3]);
plotPics('PICS/NA.png',[-.069 .59 .5 .3]);

%% p200 version
figure('Name','p200 version')

subplot(1,2,1)
p200_plotPeaks('PICS/Picture1.tif',10);
subplot(1,2,2)
p200_plotPeaks('PICS/Picture2.tif',10);
plotPics('PICS/NA.png',[.37 .59 .5 .3]);
plotPics('PICS/NA.png',[-.069 .59 .5 .3]);