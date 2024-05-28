% Read the image
imageFile = 'PICS\Picture2.tif';
bwImage = imread(imageFile);

% Display basic statistics
minValue = min(bwImage(:));
maxValue = max(bwImage(:));
disp(['Min Value: ', num2str(minValue)]);
disp(['Max Value: ', num2str(maxValue)]);

% Histogram of the pixel values
% figure;
% histogram(bwImage);
% title('Histogram of Pixel Values');
% xlabel('Pixel Value');
% ylabel('Frequency');

% Scale image to the range [0, 255]
bwImage = double(bwImage); % Convert to double for scaling
scaledImage = (bwImage / max(bwImage(:))) * 255;
scaledImage = uint8(scaledImage); % Convert back to uint8 if needed

% Verify the scaling
maxValueScaled = max(scaledImage(:));
disp(['Max Value after Scaling: ', num2str(maxValueScaled)]);

% Display the scaled image
% imageViewer(scaledImage);
