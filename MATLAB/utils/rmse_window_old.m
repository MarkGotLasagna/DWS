function V_rmse = rmse_window(V, window_size)
% RMSE_WINDOW  Find rooted mean squared errors (in a moving window)
% to detect motion changes.
%
% V_rmse = rmse_window(V, window_size);
    rmse_values = size(V, 1)-window_size;
    for j=1:4
        v1 = V(:, j);
        vsize = size(v1, 1)-window_size;
        for i=1:vsize
            window = v1(i:i+window_size);
            squared_errors = (window - mean(window)).^2;
            rmse = sqrt(mean(squared_errors));
            rmse_values(i) = rmse;
        end
        
        figure;
        hold on;
        plot(v1);
        plot(rmse_values);
        legend('intensity', 'mean squared error');
        grid on;
        title("pic4 col" + j + " win-size=" + window_size);
    end    
end