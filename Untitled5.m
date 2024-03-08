close all force
clear;
clc;

% Read in the source and target images
source_img = imread('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\21.png');
target_img = imread('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\bt2.jpg');

% Read in the image
img = imread('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\21.png');

% Convert the image to the L*a*b* color space
lab = rgb2lab(img);

% Use k-means clustering to perform color segmentation
k = 2;
[cluster_idx, cluster_center] = kmeans(lab, k);

% Create a blank mask image
mask = zeros(size(img, 1), size(img, 2));

% Fill the mask image with pixel values from the cluster index
mask(cluster_idx == 1) = 1;
mask(cluster_idx == 2) = 1;

% Use a morphological operation to clean up the mask image
mask = imerode(mask, ones(5, 5));
mask = imdilate(mask, ones(5, 5));

% Display the original and segmented images
imshow(img);
figure;
imshow(mask);