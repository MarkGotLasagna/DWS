%% To plot functions of maximum factors of columns (200) over rows (10000)
%
% This function is to be included in files such as 'main.m'
% to highlight transient peaks positions present in pictures taken by the line camera.
%
% 'filname'     The name of the picture to be displayed along the plot
% 'blocks'      The number of blocks to be used when computing the norm
function [] = p200_plotPeaks(filename, blocks)

    V = tiffreadVolume(filename); % It is advised to put .tif in the same folder as the executable

    Vsize = size(V);
    xvalues = 0:Vsize(1) - blocks -1 ;
    avg_change(Vsize(1) - blocks) = 0; % avg_change = [];
    arr_max(Vsize(1)) = 0;

    % We use the norm of blocks to reduce noise in the plot
    % otherwise nothing interesting would appear
    for i = 1:Vsize(1) - blocks
        change = single(V(i + blocks, :)) - single(V(i, :));
        avg_change(i) = norm(change);
    end

    V = imgaussfilt(V,3); % We reduce the noise by applying a Gaussian filter

    for i = 1:Vsize(1) - blocks
        arr_max(i) = max(V(i, :));
        arr_max(i+blocks) = max(V(i+blocks, :));

        change = single(V(i + blocks,:)) - single(V(i,:));
        avg_change(i) = norm(change / max(arr_max(1), arr_max(1+blocks)));
    end

    hold on
    plot(xvalues, avg_change,'r-');
    ylim([0 2]);
    title(["\textbf{p200 Transient Peaks from }",filename],'Interpreter','latex')
    subtitle(["Using blocks of size ",blocks],'Interpreter','latex')
    xlabel('Row','Interpreter','latex')
    ylabel('Column','Interpreter','latex')
    legend('p200 Gaussian Filtered Norm')
    grid on

end