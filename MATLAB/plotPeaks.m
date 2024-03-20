%% To plot functions of columns (200) over rows (10000)
%
% This function is to be included in files such as 'main.m'
% to highlight transient peaks positions present in pictures taken by the line camera.

% 'filname'     The name of the picture to be displayed along the plot
% 'blocks'      The number of blocks to be used when computing the norm
function [] = plotPeaks (filename, blocks)

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