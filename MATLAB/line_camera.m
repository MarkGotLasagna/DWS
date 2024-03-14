%% SHOW "supposedly" WHERE A TRANSIENT PEAK IS

% USAGE
% Transient peaks are evident spikes in the plots. The spikes can be
% further highlighted using a Gaussian filter (gamma=3). The function
% 'plotPeaks' takes two arguments:
% - 'filename'  The path of the .tif to be loaded.
% - 'blocks'    The number of blocks to be used to compute the norm
%
% 'plotPics' takes two arguments:
% - 'filename'  The path of the cropped .tif to be displayed along the plot
% - 'pos'       The position of the cropped .tif (as it could hide the peak plotted)
%
% The user shall change the filenames and positions according to their
% needs. NOTE: the best resolution for the cropped picture to work natively without need 
% to change the aspect ratio is 400x200. This executable does not crop the
% full .tif automatically

clear,clc,close all,hold off;

subplot(1,2,1)
plotPeaks('Picture3.tif',10);
subplot(1,2,2)
plotPeaks('Picture4.tif',10);
plotPics('Picture4_400x200.tif',[.37 .59 .5 .3]);
plotPics('Picture3_400x200.tif',[-.069 .59 .5 .3]);

function [] = plotPeaks (filename, blocks)

    V = tiffreadVolume(filename); % It is advised to put .tif in the same folder as the executable

    Vsize = size(V);
    xvalues = 0:Vsize(1) - 1;
    avg_change(Vsize(1)) = 0;

    % We use the norm of blocks to reduce noise in the plot
    % otherwise nothing interesting would appear
    for i = 1:Vsize(1) - blocks
        change = single(V(i + blocks, :)) - single(V(i, :));
        avg_change(i) = norm(change);
    end

    hold on
    plot(xvalues, avg_change,'b-');
    grid on
    title(["\textbf{Transient peaks from }",filename],'Interpreter','latex')
    subtitle(["Using blocks of size ",blocks],'Interpreter','latex')
    xlabel('Row','Interpreter','latex')
    ylabel('Column','Interpreter','latex')

    V = imgaussfilt(V,3); % We reduce the noise by applying a Gaussian filter
    for i = 1:Vsize(1) - blocks
        change = single(V(i + blocks,:)) - single(V(i,:));
        avg_change(i) = norm(change);
    end

    plot(xvalues, avg_change,'r-');
    title(["\textbf{Transient peaks from }",filename],'Interpreter','latex')
    subtitle(["Using blocks of size ",blocks],'Interpreter','latex')
    xlabel('Row','Interpreter','latex')
    ylabel('Column','Interpreter','latex')
    legend('Norm','Gaussian Filtered Norm')
end

% Starting positions by default
% [.37 .59 .5 .3]
% [-.069 .59 .5 .3]
function [] = plotPics (filename, pos)
    axes('Position',pos);
    imshow(filename);
end