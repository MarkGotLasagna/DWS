function V_rmse = rmse_window(V, window_size)
% RMSE_WINDOW  Find rooted mean squared errors (in a moving window)
% to detect motion changes.
%
% V_rmse = rmse_window(V, window_size);

    % Initialize rmse_values to the correct size
    num_columns = size(V, 2);
    rmse_values = zeros(size(V, 1) - window_size, num_columns);
    
    % Loop over each row within the window size
    for i = 1:(size(V, 1) - window_size)
        % Extract the window for all columns at once
        window = V(i:i+window_size, 1:num_columns);
        
        % Compute the mean for each column within the window
        window_means = mean(window, 1);
        
        % Compute the squared errors for each column
        squared_errors = (window - window_means).^2;
        
        % Compute the RMSE for each column
        rmse = sqrt(mean(squared_errors, 1));
        
        % Store the RMSE values for the current window
        rmse_values(i, :) = rmse;
    end

    V_rmse = rmse_values;
end