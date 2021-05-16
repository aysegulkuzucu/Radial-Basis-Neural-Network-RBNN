function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS computes the mean of all the data points
%in each cluster and assign the calculated mean as new
%centroid of the cluster.

  [m n] = size(X);
  centroids = zeros(K,n);

  for i = 1:K
    xi = X(idx == i,:);
    ck = size(xi,1);
    centroids(i,:) = (1/ck) * sum(xi);
  end
end
