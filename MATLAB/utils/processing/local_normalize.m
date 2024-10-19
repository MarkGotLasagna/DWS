function V_norm = local_normalize(V, v01, v99)
% LOCAL_NORMALIZE  Normalizes data in V using v01 and v99 as min value and
% max value: x = (x - x_min) / (x_max - x_min);
% Version R2024a needed.
%
% V_norm = local_normalize(V, v01, v99);
%
%   See also COLUMN_SMOOTH.

    % Create the MATRIX with all columns equal to the given array
    [~, num_cols] = size(V);
    V01 = v01 * ones(num_cols, 1)';
    
    % Subtract 1st percentile (x_min)
    V = V - V01;
    
    % Divide by the difference between
    % 99th percentile and 1st percentile (x_max - x_min)
    V = V ./ (v99 - V01);  % warning: array - matrix (= matrix)

    % Clip values in range [0, 1]
    V_norm = clip(V, 0, 1);
end