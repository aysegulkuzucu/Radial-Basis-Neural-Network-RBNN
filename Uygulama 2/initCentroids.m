
function centroids = initCentroids(X,K)
%CENTROIDS initializes the K centroids and
%returns K random indices from X as centroids
%randperm method will randomly reorder the indices
% of the dataset

  centroids = zeros(K, size(X,2));
  randidx = randperm(size(X,1));
  centroids = X(randidx(1:K), :);
end
