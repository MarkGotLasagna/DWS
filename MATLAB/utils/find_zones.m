function z = find_zones(correlations, l)
    points = find(correlations < l); % points in event
    shifted = circshift(points, -1); 
    diff = points - shifted; % find almost continue values
    zones = (abs(diff) < 100) .* points;
    zones = zones';
    mask = zones == 0;
    starts = strfind([true mask], [1 0]);
    stops = strfind([mask true], [0 1]);
    z = arrayfun(@(T,P) zones(T:P), starts, stops, 'uniform', 0);
end