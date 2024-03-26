%% Plot pictures accompanying plotted curves

% 'filename'    The name of the picture to be plotted
%               A file called 'NA.png' is provided in case no cropped .tif
%               is available
% 'pos'         The position of the picture
%               Depending where transient peaks appear, it is advised 
%               to change this value from the defaults in 'linecamera.m'
%
% Starting positions by default (whole figure)
% [.37 .59 .5 .3]   (subplot(1,2,1))
% [-.069 .59 .5 .3] (subplot(1,2,2))
function [] = plot_pics (filename, pos)
    axes('Position',pos);
    imshow(filename);
end