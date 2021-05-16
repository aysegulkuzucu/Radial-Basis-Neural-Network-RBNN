
% init
clear all; clc


input_train = '6.6_inputs.csv';
output_train = '6.6_output.csv';
input_test = '6.4_inputs.csv';
output_test = '6.4_output.csv';
% number of centroids
K_centroids = 2;

% loading data 
X_train = csvread(input_train);
y_train = csvread(output_train);
X_test =  csvread(input_test);
y_test = csvread(output_test);
% some useful values
m = size(X_train,1);

% plotting data
plotData(X_train,y_train);

% plotting graph labels
hold on;
% labels and legends
xlabel('variavel 1');
ylabel('variavel 2');
%legend('Presenca','Ausencia');
title('Presenca de radiacao em determinadas substancias');
%hold off;

% ====================== K-means clustering ======================
% in order to implement the rbf network, we need to determine
% the centers of each neurons receptive field using K-means
% clustering.

% K-means algorithm steps :
% 1.Choose the number of cluster centers “K”.
% 2.Randomly choose K points from the dataset and set them as K centroids of the data.
% 3.For all the points in the dataset, determine the centroid closest to it.
% 4.For all centroids, calculate the average of all the points lying closest to the same centroid.
% 5.Change the value of all the centroids to corresponding averages calculated in (4).
% 6.Go to (3) until convergence.


fprintf('Calculando os agrupamentos através de K-means...\n');
fprintf('pressione ENTER para continuar\n');
pause;

% using only rad positive substances
plus_ones = find(y_train == 1);
rad_subs = [X_train(plus_ones,1), X_train(plus_ones,2)];


% number of times we'll iterate the kmeans algorithm.
max_iter_k_means = 10;

centroids = initCentroids(rad_subs,K_centroids);

% other methods of stopping criteria can be used
% (e.g. no assigment of data point to different clusters)
% but for starters here we'll use max iterations
for i=1:max_iter_k_means
  indices = getClosestCentroids(rad_subs,centroids);
  centroids = computeCentroids(rad_subs, indices, K_centroids);
end

centroids
indices;

% separate the two groups of clusters so we can
% calculate variance
group_1 = find(indices == 1);
group_2 = find(indices == 2);

vals_1 = [rad_subs(group_1,1), rad_subs(group_1,2)];
vals_2 = [rad_subs(group_2), rad_subs(group_2,2)];

varianceg1 = var(vals_1,0,1);
varianceg2 = var(vals_2,0,1);

fprintf('Centroide do cluster 1 :( %.4f , %.4f ) \n',centroids(1,1),centroids(1,2))
fprintf('Centroide do cluster 2 : ( %.4f , %.4f ) \n',centroids(2,1),centroids(2,2))


fprintf('Variancia do cluster 1 :( %.4f , %.4f ) \n',varianceg1(1),varianceg1(2))
fprintf('Variacia do cluster 2 : ( %.4f , %.4f ) \n',varianceg2(1),varianceg2(2))


% plot the centroids
for i = 1:size(centroids,1)
  plot(centroids(i,1), centroids(i,2), '*r', 'LineWidth', 2, 'MarkerSize', 7);
end
legend('Substancias','Centroides');

hold off;

% ====================== RBF neural net ======================
fprintf( 'Inicializando RBFN...\n' );
fprintf(' Pressione ENTER para continuar\n ');
pause

spread = 1; % choosing a spread constant

% max number of neurons
K = 2;

% performance goal (SSE)
goal = 0.0;

% number o neurons to add between displays
Ki = 1;

% create a neural network
net = newrb(X_train', y_train', goal, spread, K, Ki);

% view network
view(net);

% simulate RBFN on training data
Y = sim(net, X_test');

Ypos = [];
for i = 1:length(Y)
  if(Y(i) >= 0)
    Ypos(i) = 1;
  else
    Ypos(i) = -1;
  end
end

correct = 100* length(find(y_test'.*Y > 0)) / length(y_test);
fprintf('\nSpread = %.2f\n',spread)
fprintf('Num of neurons = %d\n',net.layers{1}.size)
fprintf('correct rate = %.2f %%\n',correct)

% plot targets and network response
figure;
plot(y_test)
hold on
grid on
plot(Y','r')
ylim([-2 2])
set(gca,'ytick',[-2 0 2])
legend('labels','network answer')
xlabel('Sample No.')

summ = [X_test y_test Y' Ypos']
