%% COLUMN SMOOTHING:
% Gaussian smoothing on every columns

function V_smooth = column_smooth(V, sigma)
    % Generate 1D Gaussian kernel
    kernel_size = 3 * sigma * 2 + 1; % Choose kernel size based on column sigma
    gaussian_kernel = fspecial('gaussian', [kernel_size, 1], sigma);
    
    % Perform Gaussian filtering on every vector along the first coordinate
    V_smooth = conv2(V, gaussian_kernel, 'valid'); 
end