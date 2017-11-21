%Reading image 
%(Add the image name present in the folder as character array parameter below)

i=imread('gecko.jpg');

%value of k change according to the image selected
k=4;
idx=segmentImg(i, k); %Segmentation of source image(animal)
%imagesc(idx) To displayy segmented output of images
o=imread('bg.jpg'); %Read destination image
%Find appropriate values for foreground clusters below for three animals
%along with appropriate values of k

%cheetah k=3 fgs=[3,2];
%dog  k=4 fgs= [4,3];
%gecko k=4 fgs = [3,2];

fgs=[3,2];
n=transferImg(fgs,idx,i,o); %Transfering from source to destination
imagesc(n) %Displaying final image
