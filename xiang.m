close all force
clear;
clc;
% Initialize input and output image variables
source_img = imread('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\21.png');
target_img = imread('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\New folder\bt2.jpg');
figure()
imshow(source_img)
figure()
imshow(target_img)

% Convert the images to the CIELAB color space
source_lab = rgb2lab(source_img);
target_lab = rgb2lab(target_img);

% Split the images into their color channels
source_l = source_lab(:,:,1);
source_a = source_lab(:,:,2);
source_b = source_lab(:,:,3);

target_l = target_lab(:,:,1);
target_a = target_lab(:,:,2);
target_b = target_lab(:,:,3);
% Calculate the mean and standard deviation of the L, a, and b channels
% for the source and target images
source_l_mean = mean(source_l(:));
source_a_mean = mean(source_a(:));
source_b_mean = mean(source_b(:));

source_l_std = std(source_l(:));
source_a_std = std(source_a(:));
source_b_std = std(source_b(:));

target_l_mean = mean(target_l(:));
target_a_mean = mean(target_a(:));
target_b_mean = mean(target_b(:));

target_l_std = std(target_l(:));
target_a_std = std(target_a(:));
target_b_std = std(target_b(:));

% Transfer the color of the source image to the target image
transferred_l = (target_l - target_l_mean) .* (source_l_std / target_l_std) + source_l_mean;
transferred_a = (target_a - target_a_mean) .* (source_a_std / target_a_std) + source_a_mean;
transferred_b = (target_b - target_b_mean) .* (source_b_std / target_b_std) + source_b_mean;

% Merge the transferred color channels into an RGB image
transferred_rgb = lab2rgb(cat(3, transferred_l, transferred_a, transferred_b));
figure()
imshow(transferred_rgb)

CTQM(transferred_rgb,target_img,source_img)