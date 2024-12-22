clc;
clear;
close;

// Read the input image
img = imread("input_football_color_histogram.png");

// Convert RGB to HSV
img_hsv = rgb2hsv(img);




// Extract the V (Value) channel
V = img_hsv(:, :, 3);

// Perform histogram equalization on the V channel
[m, n] = size(V);
V_flat = round(V * 255); // Scale to 0–255 for histogram computation
hist = zeros(1, 256);
for i = 1:256
    hist(i) = length(find(V_flat == (i - 1)));
end
pdf = hist / (m * n);
cdf = cumsum(pdf);
V_eq = uint8(round(cdf(V_flat + 1) * 255));

// Replace the equalized V channel in the HSV image
img_hsv(:, :, 3) = V_eq / 255; // Scale back to 0–1

// Convert back to RGB
img_eq = hsv2rgb(img_hsv);

// Display results
subplot(1, 2, 1);
imshow(img);
title("Original Image");

subplot(1, 2, 2);
imshow(img_eq);
title("Histogram Equalized Image");

// Save output
imwrite(img_eq, "color_histogram_equalized.png");