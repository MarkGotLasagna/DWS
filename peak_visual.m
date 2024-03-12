%% VISUALIZATION OF INTERESTING PEAKS FROM THE g(2) data

clear,clc,close all,hold off;

whos("-file","S101A2-02_R000_correlation_map.mat");

% Import specific variables to workspace, we don't need them all
load("S101A2-02_R000_correlation_map.mat", "-mat", ...
    "g2_map","g2_norm","contrast","lagtimes","dt");

% Highlight data
g2_map = ((g2_map-1)./(g2_map(1,:)-1));

% Visualize data (1st window)
imagesc(g2_map,[0 1])
title("g(2)\_map","Highlighted data from the modified g(2)\_map"),
    xlabel("Column"), ylabel("Row"), colorbar

% Visualize peaks (2nd window)
figure

subplot(1,2,1)
imagesc(g2_map((1:20),:),[0,1])
title("Twin peaks visible at 1:20"),
    xlabel("Column"),ylabel("Row"),colorbar

subplot(1,2,2)
imagesc(g2_map(:,(101100:101200)),[0,1])
title("Enlarged left peak"),
    xlabel("Column"),ylabel("Row"),colorbar