%% To plot _local normalized_ functions of columns (200) over rows (10000)
%
% This function is to be included in files such as 'main.m'
% to highlight transient peaks positions present in pictures taken by the line camera.

% 'filname'     The name of the picture to be displayed along the plot
% 'blocks'      The number of blocks to be used when computing the norm
function [] = ln_plot_peaks (filename, blocks)

    V = tiffreadVolume(filename);

    V = mat2gray(V);    % (0-1)

    V = localnormalize(V,4,4);  % Problematic: false positives beginning and end of plot
                                % Here the picture will be black and white

    V = mat2gray(V);    % (0-1)

    Vsize = size(V);
    xvalues = 0:Vsize(1) - blocks -1 ;
    avg_change(Vsize(1) - blocks) = 0; % avg_change = [];

    % We use the norm of blocks to reduce noise in the plot
    % otherwise nothing interesting would appear
    for i = 1:Vsize(1) - blocks
        change = single(V(i + blocks, :)) - single(V(i, :));
        avg_change(i) = norm(change);
    end

    hold on
    plot(xvalues, avg_change,'b-');
    grid on
    title(["\textbf{LN Transient Peaks from }",filename],'Interpreter','latex')
    subtitle(["Using blocks of size ",blocks],'Interpreter','latex')
    xlabel('Row','Interpreter','latex')
    ylabel('Column','Interpreter','latex')

    V = imgaussfilt(V,1); % We reduce the noise by applying a Gaussian filter
    for i = 1:Vsize(1) - blocks
        change = single(V(i + blocks, :)) - single(V(i, :));
        avg_change(i) = norm(change);
    end

    plot(xvalues, avg_change,'r-');
    title(["\textbf{LN Transient Peaks from }",filename],'Interpreter','latex')
    subtitle(["Using blocks of size ",blocks],'Interpreter','latex')
    xlabel('Row','Interpreter','latex')
    ylabel('Column','Interpreter','latex')
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