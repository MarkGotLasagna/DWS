function V_smooth = bilateral_smooth(V, sigma)
% BILATERAL_SMOOTH  Applies bilateral smoothing on each column to reduce
% noise and makes edge detection much easier.
%
% V_smooth = bilateral_smooth(V, sigma);
%
%   See also LOCAL_NORMALIZE, GAUSSIAN_SMOOTH, MEDIAN_SMOOTH.
    V_smooth = V;
    for i=1:size(V, 2)
        intensity_sigma = 2*std(V(:, i))^2;
        V_smooth(:, i) = bilateralFilter1D(V(:, i), sigma, intensity_sigma);
    end
end

function output = bilateralFilter1D(signal, sigma_spatial, sigma_intensity, window_size)
    % Validate inputs
    if nargin < 4
        window_size = 2 * ceil(2 * sigma_spatial) + 1; % Default window size based on sigma_spatial
    end
    
    % Pre-compute Gaussian spatial weights
    half_window = floor(window_size / 2);
    spatial_weights = exp(-(-half_window:half_window).^2 / (2 * sigma_spatial^2));
    
    % Initialize output signal
    output = zeros(size(signal));
    n = length(signal);
    
    % Apply the bilateral filter
    for i = 1:n
        % Define the local window
        min_index = max(1, i - half_window);
        max_index = min(n, i + half_window);
        
        % Extract the local signal window
        local_window = signal(min_index:max_index);
        
        % Compute intensity weights
        intensity_weights = exp(-(local_window - signal(i)).^2 / (2 * sigma_intensity^2));
        
        % Combine spatial and intensity weights
        combined_weights = spatial_weights((min_index:max_index) - i + half_window + 1) .* intensity_weights;
        
        % Normalize the weights
        combined_weights = combined_weights / sum(combined_weights);
        
        % Compute the filtered value
        output(i) = sum(combined_weights .* local_window);
    end
end