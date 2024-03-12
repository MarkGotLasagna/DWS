clear;
clc;
close all;

V = tiffreadVolume("0038_S101A2-02_R000_2_000808_20220702_081406_000000551.tif");

Vsize = size(V);
xvalues = 0:Vsize(1)-1;
avg_change(Vsize(1)) = 0;
for i = 1:Vsize(1)-50
    change = single(V(i+50, :)) - single(V(i, :));
    avg_change(i) = norm(change);
end 

plot(xvalues, avg_change);