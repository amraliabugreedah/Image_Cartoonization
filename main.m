clc
clear history
close all
quantized = quantize('boy.jpg');
biFiltOutput = bilateralFilter(quantized, 1222.0, 622.0);
gaussFiltOutput = gaussFilter('boy.jpg', 0.5, 0.7);
biFilt = double(biFiltOutput);
% figure
% imshow(biFiltOutput);
% figure
% imshow(uint8(gaussFiltOutput));
output = biFilt .* ~gaussFiltOutput;
% size(biFilt)
% size(gaussFiltOutput)
% output(:, :, 1) = biFilt(:, :, 1) .* (~gaussFiltOutput(:, :, 1));
% output(:, :, 2) = biFilt(:, :, 2) .* ~gaussFiltOutput(:, :, 2);
% output(:, :, 3) = biFilt(:, :, 3) .* ~gaussFiltOutput(:, :, 3);

figure('Name', 'Final');
imshow(uint8(output));