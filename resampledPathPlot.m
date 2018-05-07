%% Final path plot
figure (5)
hold on
for i = 1 : size(path, 1)
    plot (path(i, 1), path(i, 2), 's', 'MarkerSize', 4, 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
    pause(0.05)
end
axis equal