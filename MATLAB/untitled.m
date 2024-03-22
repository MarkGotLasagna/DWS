% Generate 1D Gaussian kernel
kernelSize = ceil(3 * sigma) * 2 + 1; % Choose kernel size based on sigma
gaussianKernel = fspecial('gaussian', [1, kernelSize], sigma);

% Perform Gaussian filtering on every vector along the first coordinate
filteredMatrix = conv2(matrix, gaussianKernel, 'same');