% Load the two images
img1 = imread('C:\Users\siama\OneDrive\Έγγραφα\DIPLOMA\Images\Targets\36.jpg');
% Load an image
% Load an image
img = img1;

% Convert the image to Lab color space
lab = rgb2lab(img);

% Extract the a and b components
a = lab(:,:,2);
b = lab(:,:,3);

% Define the number of bins for the histogram
num_bins = 64;

% Compute the histogram using the histcounts2 function
histogram = histcounts2(a, b, num_bins);

% Generate a grid for the a and b component values
[a_grid, b_grid] = meshgrid(linspace(min(a(:)), max(a(:)), size(histogram,1)), linspace(min(b(:)), max(b(:)), size(histogram,2)));

% Define the size of each bin in the a and b components
da = (max(a(:))-min(a(:))) / (size(histogram,1)-1);
db = (max(b(:))-min(b(:))) / (size(histogram,2)-1);

% Create a surface plot of the histogram using the surf function
figure;
surf(a_grid, b_grid, histogram);
colormap('jet');
colorbar;
xlabel('α');
ylabel('β ');
zlabel('Συχνοτητα');