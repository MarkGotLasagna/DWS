function [x, y] = find_peaks(correlations, zones)
    peaks = cell(1, length(zones));
    points = cell(1, length(zones));
    for i=1:length(zones)
        zone = zones{i};
        corrs = correlations(zone);
        min_val = min(corrs);
        event_start = find(correlations == min_val);
        event_end = event_start + 1500;
        if(event_start > size(correlations, 1) - 1500)
            event_end = size(correlations, 1);
        end
        points{i} = (event_start:event_end)';
        peaks{i} = correlations(event_start:event_end);
    end

    for i=1:length(points)-1
        event_start = points{i}(1);
        event_end = points{i}(end);
        next = zones{i+1}(1);
        if(event_end > next)
            event_end = next-75;
        end
        points{i} = (event_start:event_end)';
        peaks{i} = correlations(event_start:event_end);
    end
    x = points;
    y = peaks;
end