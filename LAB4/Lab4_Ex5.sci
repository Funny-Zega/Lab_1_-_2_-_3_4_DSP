// 1. Read a built-in standard image from the IPCV module
img_path = fullpath(getIPCVpath() + "/images/lena.png");
img_rgb = imread(img_path);

// 2. Convert RGB to Grayscale (simplifies 3D matrix to 2D matrix)
img_gray = rgb2gray(img_rgb);

// 3. Demo 1: Histogram Equalization (Improves contrast)
img_eq = imhistequal(img_gray);

// 4. Demo 2: Spatial Filtering - Image Blur (using an Averaging Filter)
// Create a 7x7 average filter mask (impulse response h[m,n])
h_blur = fspecial('average', 7); 
// Apply 2D Convolution between the image and the filter mask
img_blur = imfilter(img_gray, h_blur);

// 5. Visualization
figure(1);

// Show Original Grayscale
subplot(2,2,1); 
imshow(img_gray); 
title("1. Original Grayscale");

// Show Original Histogram
subplot(2,2,2); 
imhist(img_gray); 
title("2. Original Histogram");atomsLoad("IPCV");

// 1. Read image and convert to grayscale
img_path = fullpath(getIPCVpath() + "/images/lena.png");
img_rgb = imread(img_path);
img_gray = rgb2gray(img_rgb);

// 2. Histogram Equalization (Contrast enhancement)
img_eq = imhistequal(img_gray);

// 3. Image Blur (Spatial filtering via convolution)
h_blur = fspecial('average', 7); 
img_blur = imfilter(img_gray, h_blur);

// 4. Visualization
figure(1);
clf();

subplot(2,2,1); 
imshow(img_gray); 
title("1. Original Grayscale");

subplot(2,2,2); 
[counts, bins] = imhist(img_gray); // Extract data to avoid rendering bugs
bar(bins, counts, 0, 'black');     // Plot manually
title("2. Original Histogram");

subplot(2,2,3); 
imshow(img_eq); 
title("3. Histogram Equalized");

subplot(2,2,4); 
imshow(img_blur); 
title("4. Blurred Image (7x7 Filter)");

// Show Equalized Image
subplot(2,2,3); 
imshow(img_eq); 
title("3. Histogram Equalized");

// Show Blurred Image
subplot(2,2,4); 
imshow(img_blur); 
title("4. Blurred Image (7x7 Filter)");
