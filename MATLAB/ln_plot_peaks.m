% LN_PLOT_PEAKS    Plot locally normalized transient peaks.
%   LN_PLOT_PEAKS(filename, blocks) prints the norm of a locally normalized 
%   change computed using blocks. Just like PLOT_PEAKS, this version plots
%   two curves: the blue one represents the norm as is, while the red one has a
%   gaussian filter applied to it. The difference between the two versions
%   is the local normalization applied to the picture just before computing
%   the norm.
%
%   Example
%       ln_plot_peaks('PICS/Picture1.tif',10);
%
%   See also TIFFREADVOLUME, IMGAUSSFILT, MAT2GRAY, NORM, PLOT_PEAKS

%% PROVARE CON NORMA L2

function [] = ln_plot_peaks (filename, region, blocks)

    V = tiffreadVolume(filename);

    if ischar(region) && region == "all"
        region = 1:max(size(V));
    end

    V = V((region),:);

    V = mat2gray(V);    % (0-1)

    V = localnormalize(V,4,4);  % Problematic: false positives beginning and end of plot
                                % Here the picture will be black and white

    V = mat2gray(V);    % (0-1)

    % We use the norm of blocks to reduce noise in the plot
    % otherwise nothing interesting would appear
    change = single(V(blocks + 1:end, :)) - single(V(1:end - blocks, :));
    avg_change = sqrt(sum(change.^2, 2));

    % for i = 1:Vsize(1) - blocks
    %     change = single(V(i + blocks, :)) - single(V(i, :));
    %     avg_change(i) = norm(change);
    % end

    hold on
    plot(avg_change,'b-');
    grid on
    title(["\textbf{LN Transient Peaks from }",filename],'Interpreter','latex')
    subtitle(["Using blocks of size ",blocks],'Interpreter','latex')
    xlabel('time (t)','Interpreter','latex')
    ylabel('Motion changes','Interpreter','latex')

    V = imgaussfilt(V,1); % We reduce the noise by applying a Gaussian filter
    
    change = single(V(blocks + 1:end, :)) - single(V(1:end - blocks, :));
    avg_change = sqrt(sum(change.^2, 2));

    t = mfilename + ".m";
    st = "#blocks: " + blocks;

    plot(avg_change,'r-');
    title(t,'Interpreter','none','VerticalAlignment','baseline')
    subtitle(st,'Interpreter','none')
    xlabel('time (t)','Interpreter','latex')
    ylabel('Motion changes','Interpreter','latex')
    legend('LN Norm','LN Gaussian Filtered Norm')
end

%% Local Normalization
%
% Reduce the difference of the illumination
% Author:   Guanglei Xiong (2024)
% Source:   MATLAB File Exchange
function ln = localnormalize(im, sigma1, sigma2)
    epsilon = 1e-1;
    halfsize1 = ceil(-norminv(epsilon/2,0,sigma1));
    size1 = 2 * halfsize1 + 1;
    halfsize2 = ceil(-norminv(epsilon/2,0,sigma2));
    size2 = 2 * halfsize2 + 1;
    gaussian1 = fspecial('gaussian', size1, sigma1);
    gaussian2 = fspecial('gaussian', size2, sigma2);
    num = im - imfilter(im,gaussian1);
    den = sqrt(imfilter(num.^2,gaussian2));
    ln = num./den;
end