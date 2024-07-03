function V_smooth = median_smooth(V, sigma)
% MEDIAN_SMOOTH  Applies median smoothing on each column to reduce
% noise and makes edge detection much easier.
%
% V_smooth = median_smooth(V, sigma);
%
%   See also LOCAL_NORMALIZE, GAUSSIAN_SMOOTH.
    V_smooth = medfilt1(V, sigma, [], 1, 'includenan', 'truncate');
end