function [output] = bilateralFilter(inputImage, sigmaD, sigmaR)
img = double(inputImage);
[r, c, ~] = size(img);
for i = 3: r-3
    for j = 3: c-3
        ksRed = 0;
        secTermRed = 0;
        ksGreen = 0;
        secTermGreen = 0;
        ksBlue = 0;
        secTermBlue= 0;
        for iWin = -2: 2
            for jWin = -2: 2
                if iWin ~= 0 || jWin ~= 0
                    FPSRed = exp(-((i-(i+iWin))^2+(j-(j+jWin))^2)/(2*(sigmaD^2)));
                    GIpIsRed = exp((-(img(i, j, 1)-img(i+iWin, j+jWin, 1))^2)/(2*(sigmaR^2)));
                    ksRed = ksRed + (FPSRed * GIpIsRed);
                    secTermRed = secTermRed + (FPSRed * GIpIsRed * img(i+iWin, j+jWin, 1));
                    %%%%%
                    FPSGreen = exp(-((i-(i+iWin))^2+(j-(j+jWin))^2)/(2*(sigmaD^2)));
                    GIpIsGreen = exp((-(img(i, j, 2)-img(i+iWin, j+jWin, 2))^2)/(2*(sigmaR^2)));
                    ksGreen = ksGreen + (FPSGreen * GIpIsGreen);
                    secTermGreen = secTermGreen + (FPSGreen * GIpIsGreen * img(i+iWin, j+jWin, 2));
                    %%%%%%
                    FPSBlue = exp(-((i-(i+iWin))^2+(j-(j+jWin))^2)/(2*(sigmaD^2)));
                    GIpIsBlue = exp((-(img(i, j, 3)-img(i+iWin, j+jWin, 3))^2)/(2*(sigmaR^2)));
                    ksBlue = ksBlue + (FPSBlue * GIpIsBlue);
                    secTermBlue = secTermBlue + (FPSBlue * GIpIsBlue * img(i+iWin, j+jWin, 3));
                end
            end
        end
        img(i, j, 1) = (1/ksRed) * secTermRed;
        img(i, j, 2) = (1/ksGreen) * secTermGreen;
        img(i, j, 3) = (1/ksBlue) * secTermBlue;
    end
end
%  figure('Name', 'biFilt output');
%  imshow(uint8(img));
 output = uint8(img);
end