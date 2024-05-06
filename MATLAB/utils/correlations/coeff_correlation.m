%% COEFFICIENT BASED CORRELATION:
% Calculate correlation based on coefficient (Pearson, Spearman, Kendall)
function correlations = coeff_correlation(V, type, interval)
    s = size(V, 1);
    correlations = zeros(s-1, 1);

    for i=1:s-interval
        correlations(i) = corr(V(i, :)', V(i+interval, :)', Type=type);
    end
end