%% SHOW "supposedly" WHERE A TRANSIENT PEAK IS

clear,clc,close all,hold off;

% The .tif to be read (line camera picture in gray scale)
V = tiffreadVolume("0038_S101A2-02_R000_2_000808_20220702_081406_000000551.tif");

Vsize = size(V);
xvalues = 0:Vsize(1)-1;
avg_change(Vsize(1)) = 0;

% We use blocks to get the norm of the vectors so that less noise is
% present in the final plot (meaningful data)
for i = 1:Vsize(1)-50
    change = single(V(i+50, :)) - single(V(i, :));
    avg_change(i) = norm(change);
end 

plot(xvalues, avg_change);