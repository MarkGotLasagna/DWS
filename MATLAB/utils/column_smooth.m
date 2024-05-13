function V_smooth = column_smooth(V, sigma)
% COLUMN_SMOOTH  Applies gaussian smoothing on each column to reduce
% noise and makes edge detection much easier.
% V_smooth = column_smooth(V, sigma);
%
%   See also LOCAL_NORMALIZE.

    % Generate 1D Gaussian kernel
    kernel_size = 3 * sigma * 2 + 1; % Choose kernel size based on column sigma
    gaussian_kernel = fspecial('gaussian', [kernel_size, 1], sigma);
    
    % Perform Gaussian filtering on every vector along the first coordinate
    V_smooth = conv2(V, gaussian_kernel, 'valid'); 
end