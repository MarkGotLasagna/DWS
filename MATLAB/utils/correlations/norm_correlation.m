%% NORM CORRELATION:
% Calculate paired rows distance (Euclidian norm)
% interval stands for the gap of compared rows
function corr = norm_correlation(V, interval)
    diff = V(interval + 1:end, :) - V(1:end - interval, :);
    corr = vecnorm(diff, 2, 2)';
end