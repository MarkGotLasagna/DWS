% P200_PLOT_PEAKS    Plot transient peaks using the max of the norm
%   P200_PLOT_PEAKS(filename, blocks) prints the maximum of the norm
%   computed for each row in the picture. Before doing so, a gaussian
%   filter is applied to reduce noise.
%   
%   Example
%       p200_plot_peaks('PICS/Picture1.tif',10);
%
%   See also TIFFREADVOLUME, IMGAUSSFILT, MAX, NORM, PLOT_PEAKS,
%   LN_PLOT_PEAKS
function [] = p200_plot_peaks(filename, region, blocks)

    V = tiffreadVolume(filename); % It is advised to put .tif in the same folder as the executable

    if ischar(region) && region == "all"
        region = 1:max(size(V));
    end

    V = V((region),:);

    Vsize = size(V);
    avg_change(Vsize(1) - blocks) = 0; % avg_change = [];
    arr_max(Vsize(1)) = 0;

    V = imgaussfilt(V,3); % We reduce the noise by applying a Gaussian filter

    for i = 1:Vsize(1) - blocks
        arr_max(i) = max(V(i, :));
        arr_max(i+blocks) = max(V(i+blocks, :));

        change = single(V(i + blocks,:)) - single(V(i,:));
        avg_change(i) = norm(change / max(arr_max(1), arr_max(1+blocks)));
    end

    t = mfilename + ".m";
    st = "#blocks: " + blocks;
    
    plot(avg_change,'r-');
    ylim([0 2]);
    title(t,'Interpreter','none','VerticalAlignment','baseline')
    subtitle(st,'Interpreter','none')
    xlabel('time (t)','Interpreter','latex')
    ylabel('Motion changes','Interpreter','latex')
    legend('p200 Gaussian Filtered Norm')
    grid on
end