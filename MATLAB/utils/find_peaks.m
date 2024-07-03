function [x, p] = find_peaks(correlations, zones)
    peaks = cell(1, length(zones));
    points = cell(1, length(zones));
    for i=1:length(zones)
        zone = zones{i};
        corrs = correlations(zone);
        min_val = min(corrs);
        event_start = find(correlations == min_val);
        event_end = event_start + 1500;
        points{i} = (event_start:event_end)';
        peaks{i} = correlations(event_start:event_end);
    end
    x = points;
    p = peaks;
end