function V_eq = histogram_equalization(V)
    eq_rows = V; % pre-allocation
    for i=1:size(V,1)
        row_i = V(i, :);
        eq_rows(i, :) = histeq(row_i);
    end

    V_eq = eq_rows;
end