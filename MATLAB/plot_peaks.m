% PLOT_PEAKS    Plot transient peaks.
%   PLOT_PEAKS(filename, region, blocks) prints the norm of a change computed using
%   blocks. Changing the blocks parameter doesn't necessarily help in highlighting transient
%   peaks, it relies on user trial and error. filename is the name of the
%   picture to be loaded which raw data (pixel intensities) is used to
%   compute the norm. Two continuous curves will be plotted: the blue curve is the
%   norm as is, while the red curve is the norm to which a gaussian filter
%   is applied. region parameter specifies the portion of the image to be
%   used: 'all' to pick the picture as a whole.
%
%   Example
%       plot_peaks('PICS/Picture1.tif',10);
%
%   See also TIFFREADVOLUME, IMGAUSSFILT
function [] = plot_peaks (filename, region, blocks)

    V = tiffreadVolume(filename);

    if ischar(region) && region == "all"
        region = 1:max(size(V));
    end

    V = V((region),:);

    change = single(V(blocks + 1:end, :)) - single(V(1:end - blocks, :));
    avg_change = sqrt(sum(change.^2, 2));

    hold on, grid on

    plot(avg_change,'b-');

    V = imgaussfilt(V,3);

    change = single(V(blocks + 1:end, :)) - single(V(1:end - blocks, :));
    avg_change = sqrt(sum(change.^2, 2));

    t = mfilename + ".m";
    st = "#blocks: " + blocks;

    plot(avg_change,'r-');
    title(t,'Interpreter','none','VerticalAlignment','baseline')
    subtitle(st,'Interpreter','none')
    xlabel('time (t)','Interpreter','latex')
    ylabel('Motion changes','Interpreter','latex')
    legend('Norm','Gaussian Filtered Norm')
end