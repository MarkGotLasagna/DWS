%% To plot functions of maximum factors of columns (200) over rows (10000)
%
% This function is to be included in files such as 'main.m'
% to highlight transient peaks positions present in pictures taken by the line camera.
%

% 'region'      The region of the image to be cropped and plotted
function [] = p300_plotPeaks(filename, region, sigma)

    % 7100 - 7600 (500)
    V = tiffreadVolume(filename); % It is advised to put .tif in the same folder as the executable
    
    V_crop = V((region),:);

    V_crop_max = max(V_crop,[],2)';

    V_crop_prctile = prctile(V_crop',95);

    V_crop_max = imgaussfilt(V_crop_max,sigma);
    V_crop_prctile = imgaussfilt(V_crop_prctile,sigma);

    V_norm = V_crop ./ V_crop_prctile'; % Problem: V_norm (0,1)
    
    s = size(V_crop_max);

    x = 0:s(2)-10-1;

    avg_change(s(2) - 10) = 0; % avg_change = [];

    for i = 1:s(2) - 10
        change = single(V_norm(i + 10, :)) - single(V_norm(i, :));
        avg_change(i) = norm(change);
        % if i == Vsize(1) - blocks
        %     fprintf('Ciaone');
        % end
    end

    figure
    hold on
    subplot(1,2,1)
    plot(x, V_crop_max(:,(1:491)),'r-');
    
    subplot(1,2,2)
    plot(x, avg_change,'b-');
    

end