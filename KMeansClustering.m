function idx = KMeansClustering(X, k, centers)
% Run the k-means clustering algorithm.
%
% INPUTS
% X - An array of size m x n containing the points to cluster. Each row is
%     an n-dimensional point, so X(i, :) gives the coordinates of the ith
%     point.
% k - The number of clusters to compute.
% centers - OPTIONAL parameter giving initial centers for the clusters.
%           If provided, centers should be a k x n matrix where
%           centers(c, :) is the center of the cth cluster. If not provided
%           then cluster centers will be initialized by selecting random
%           rows of X. You don't need to use this parameter; it is mainly
%           here to make your code more easily testable.
%
% OUTPUTS
% idx     - The assignments of points to clusters. idx(i) = c means that the
%           point X(i, :) has been assigned to cluster c.

    if ~isa(X, 'double')
        X = double(X);
    end
    m = size(X, 1);
    n = size(X, 2);
    
    
    % If initial cluster centers were not provided then initialize cluster
    % centers to random rows of X. Each row of the centers variable should
    % contain the center of a cluster, so that centers(c, :) is the center
    % of the cth cluster.
    if ~exist('centers', 'var')
        centers = zeros(k, n);
    end
    
    randR=randperm(m); %A random function of size of each row m
    
    for y=1:k %for each value of k
        x=randR(y); %random values for row selection
        centers(y,:)=X(x,:); %assigning initial centers
        
    end
    
    % The assignments of points to clusters. If idx(i) == c then the point
    % X(i, :) belongs to the cth cluster.
    idx = zeros(m, 1);

    % The number of iterations that we have performed.
    iter = 0;
    
    % If the assignments of points to clusters have not converged after
    % performing MAX_ITER iterations then we will break and just return the
    % current cluster assignments.
    MAX_ITER = 100;
    
    while true        
        % Store old cluster assignments
        old_idx = idx;
        for i=1:m
            min =1; 
            v=norm(X(i,:) - centers(min,:)); %value of distance to centroid
            for j=1:k %for each value of k
                d=norm(centers(j,:)-X(i,:)); %moving centroid 
                if d < v 
                    min=j; %new minimum
                    v=d; %new minimum distance
                end
            end
          idx(i)=min; %attaching cluster id
        end
        for x=1:k %for each value of k
            centers(x,:)=sum(X(find(idx == x),:));  %finding centers total 
            centers(x,:) = centers(x,:)/length(find(idx==x)); %finding mean
        end
        
        if idx == old_idx %if no change
            break;
        end
        
        
        % Stop early if we have performed more than MAX_ITER iterations
        iter = iter + 1;
        if iter > MAX_ITER
            break;
        end
    end
end
