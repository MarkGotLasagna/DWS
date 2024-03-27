% PLOT_PEAKS    Plot transient peaks.
%   PLOT_PEAKS(filename, blocks) prints the norm of a change computed using
%   blocks. Changing the blocks parameter doesn't necessarily help in highlighting transient
%   peaks, it relies on user trial and error. filename is the name of the
%   picture to be loaded which raw data (pixel intensities) is used to
%   compute the norm. Two continuous curves will be plotted: the blue curve is the
%   norm as is, while the red curve is the norm to which a gaussian filter
%   is applied.
%
%   Example
%       plot_peaks('PICS/Picture1.tif',10);
%
%   See also TIFFREADVOLUME, NORM, IMGAUSSFILT
function [] = plot_peaks (filename, blocks)

    V = tiffreadVolume(filename); % It is advised to put .tif in the same folder as the executable

    Vsize = size(V);
    xvalues = 0:Vsize(1) - blocks -1 ;
    avg_change(Vsize(1) - blocks) = 0; % avg_change = [];

    % We use the norm of blocks to reduce noise in the plot
    % otherwise nothing interesting would appear
    for i = 1:Vsize(1) - blocks
        change = single(V(i + blocks, :)) - single(V(i, :));
        avg_change(i) = norm(change);
        % if i == Vsize(1) - blocks
        %     fprintf('Ciaone');
        % end
    end

    hold on
    plot(xvalues, avg_change,'b-');
    grid on
    title(["\textbf{Transient Peaks from }",filename],'Interpreter','latex')
    subtitle(["Using blocks of size ",blocks],'Interpreter','latex')
    xlabel('Row','Interpreter','latex')
    ylabel('Column','Interpreter','latex')

    V = imgaussfilt(V,3); % We reduce the noise by applying a Gaussian filter
    for i = 1:Vsize(1) - blocks
        change = single(V(i + blocks, :)) - single(V(i, :));
        avg_change(i) = norm(change);
    end

    plot(xvalues, avg_change,'r-');
    title(["\textbf{Transient Peaks from }",filename],'Interpreter','latex')
    subtitle(["Using blocks of size ",blocks],'Interpreter','latex')
    xlabel('Row','Interpreter','latex')
    ylabel('Column','Interpreter','latex')
    legend('Norm','Gaussian Filtered Norm')
end