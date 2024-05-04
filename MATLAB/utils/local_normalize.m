%% LOCAL NORMALIZING: 
% x = (x - x_min) / (x_max - x_min);

function V_norm = local_normalize(V, v1, v99)
    % Create the MATRIX with all columns equal to the given array
    [~, num_cols] = size(V);
    V1 = v1 * ones(num_cols, 1)';
    
    % Subtract 1st percentile (x_min)
    V = V - V1;
    
    % Divide by the difference between
    % 99th percentile and 1st percentile (x_max - x_min)
    V = V ./ (v99 - V1);  % warning: array - matrix (= matrix)

    % Clip values in range [0, 1]
    V_norm = clip(V, 0, 1);
end