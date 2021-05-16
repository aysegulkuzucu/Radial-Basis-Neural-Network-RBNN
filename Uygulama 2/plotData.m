function plotData(X,y)
%PLOTDATA Plots the data points X and y into a new figure
%   PLOTDATA(x,y) plots the data points with + for the plus one examples
%   and o for the minus ones examples. X is assumed to be a Mx2 matrix.

% Create new figure
figure; hold on;

% Find indices of 1 and -1 examples
plus_ones = find(y == 1);
minus_ones = find(y == -1);

% plot examples
plot(X(plus_ones,1), X(plus_ones,2), 'k+', 'LineWidth', 2, 'MarkerSize', 7);
%plot(X(minus_ones,1), X(minus_ones,2), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize',7);
