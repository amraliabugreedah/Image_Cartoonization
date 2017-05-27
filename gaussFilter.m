function [output] = gaussFilter(inputImage, sigmaOne, sigmaTwo)
myImg = imread(inputImage);
img = double(myImg);
[r, c, ~] = size(img);
filterOne = fspecial('gaussian', [3 3], sigmaOne);
filterTwo = fspecial('gaussian', [3 3], sigmaTwo);
filtImgOne = double(img);
filtImgTwo = double(img);
for i = 2: r-2
    for j = 2: c-2
        windowCurrRed = img(i-1:i+1, j-1:j+1, 1);
        windowCurrGreen = img(i-1:i+1, j-1:j+1, 2);
        windowCurrBlue = img(i-1:i+1, j-1:j+1, 3);
        newValOneRed = sum(sum(filterOne .* windowCurrRed));
        newValOneGreen = sum(sum(filterOne .* windowCurrGreen));
        newValOneBlue = sum(sum(filterOne .* windowCurrBlue));
        newValTwoRed = sum(sum(filterTwo .* windowCurrRed));
        newValTwoGreen = sum(sum(filterTwo .* windowCurrGreen));
        newValTwoBlue = sum(sum(filterTwo .* windowCurrBlue));
        filtImgOne(i, j, 1) = newValOneRed;
        filtImgOne(i, j, 2) = newValOneGreen;
        filtImgOne(i, j, 3) = newValOneBlue;
        filtImgTwo(i, j, 1) = newValTwoRed;
        filtImgTwo(i, j, 2) = newValTwoGreen;
        filtImgTwo(i, j, 3) = newValTwoBlue;
    end
end
binaryFiltImgOne = im2bw(uint8(filtImgOne), 0.39);
binaryFiltImgTwo = im2bw(uint8(filtImgTwo), 0.39);
% figure;
% imshow(binaryFiltImgOne)
output(:, :, 1) = double(myImg(:, :, 1)) .* (binaryFiltImgTwo - binaryFiltImgOne);
output(:, :, 2) = double(myImg(:, :, 2)) .* (binaryFiltImgTwo - binaryFiltImgOne);
output(:, :, 3) = double(myImg(:, :, 3)) .* (binaryFiltImgTwo - binaryFiltImgOne);
% figure;
% imshow(uint8(output));
end