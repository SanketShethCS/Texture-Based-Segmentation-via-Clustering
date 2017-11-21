
function idx = segmentImg(img, k)
% function idx = segmentImage(img,k)
% Returns the logical image containing the segment ids obtained from 
%   segmenting the input image
%
% INPUTS
% img - The input image contining textured foreground objects to be segmented
%     out.
% k - The number of segments to compute (also the k-means parameter).
%
% OUTPUTS
% idx - The logical image (same dimensions as the input image) contining 
%       the segment ids after segmentation. The maximum value of idx is k.
%          

    % 1. Create your bank of filters using the given alogrithm; 
    % 2. Compute the filter responses by convolving your input image with  
    %     each of the num_filters in the bank of filters F.
    %     responses(:,:,i)=conv2(I,F(:,:,i),'same')
    %     NOTE: we suggest to use 'same' instead of 'full' or 'valid'.
    % 3. Remember to take the absolute value of the filter responses (no
    %     negative values should be used).
    % 4. Construct a matrix X of the points to be clustered, where 
    %     the rows of X = the total number of pixels in I (rows*cols); and
    %     the columns of X = num_filters;
    %     i.e. each pixel is transformed into a num_filters-dimensional
    %     vector.
    % 5. Run kmeans to cluster the pixel features into k clusters,
    %     returning a vector IDX of labels.
    % 6. Reshape IDX into an image with same dimensionality as I and return
    %     the reshaped index image.
    %
    I = double(rgb2gray(img));
    I = I(:,:,1);
    F=makeLMfilters;
    [~,~,num_filters] = size(F);
    for i=1:num_filters     %For each filter
        responses(:,:,i)=(conv2(I,F(:,:,i),'same'));  %convolution with each filter
    end
    responses=abs(responses); %Only positive values taken into consideration
    A=size(img); %Size of original image
    rowS=A(1)*A(2); %Size of rows for matrix X
    colS=num_filters; %Size of columns for matrix X
    X=[rowS,colS];
    for r=1:colS  %For each filter
        line=responses(:,:,r);  %Matix for each filter
        line=reshape(line',[1 rowS]); %converting individual filter mat to vector
        for i=1:rowS %For each pixel
            X(i,r)=line(i); 
        end
    end
    idx=kmeans(X,k,'MaxIter',10000);%built in Kmeans function with convergence iterations limit increased to 1000
    %idx=KMeansClustering(X,k); %Self-coded kmeans
    idx=reshape(idx,[A(2) A(1)])'; %Reshaping the idx to dimensions of original image
        
end
