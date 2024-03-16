%% SHOW "supposedly" WHERE A TRANSIENT PEAK IS

% USAGE
% Transient peaks are evident spikes in the plots. The spikes can be
% further highlighted using a Gaussian filter (gamma=3). The function
% 'plotPeaks' takes two arguments:
% - 'filename'  The path of the .tif to be loaded.
% - 'blocks'    The number of blocks to be used to compute the norm
%
% subplot separation is the only task assigned to the user.

clear,clc,close all,hold off;

subplot(1,2,1)
plotPeaks('picture.tif',10);
subplot(1,2,2)
plotPeaks('picture2.tif',10);

function [] = plotPeaks(filename, blocks)

    V = tiffreadVolume(filename); % It is advised to put .tif in the same folder as the executable

    Vsize = size(V);
    xvalues = 0:Vsize(1) - 1;
    avg_change(Vsize(1)) = 0;
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
    title(["\textbf{Transient peaks from }",filename],'Interpreter','latex')
    subtitle(["Using blocks of size ",blocks],'Interpreter','latex')
    xlabel('Row','Interpreter','latex')
    ylabel('Column','Interpreter','latex')
    legend('Gaussian Filtered Norm')
    grid on

end