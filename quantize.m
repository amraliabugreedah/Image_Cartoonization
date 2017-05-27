function [output] = quantize(inputImg)
img = imread(inputImg);
%%%%%%%%Quantization
[r, c, ~] = size(img);
stepSize = 0:32:258;
for iq = 1: r
    for jq = 1: c
         [~, v1] = histc(img(iq, jq, 1), stepSize);
         [~, v2] = histc(img(iq, jq, 2), stepSize);
         [~, v3] = histc(img(iq, jq, 3), stepSize);
         img(iq, jq, 1) = stepSize(v1);
         img(iq, jq, 2) = stepSize(v2);
         img(iq, jq, 3) = stepSize(v3);
    end
end
%%%%%%%%%%%%%
hsvImg = img;
% for i = 1: r
%     for j = 1: c
%         if hsvImg(i, j, 3) < 0.2
%             hsvImg(i, j, 3) = 0;
%         else
%             hsvImg(i, j, 3) = 1;
%         end
%         
%     end
%     
% end
% imshow(hsv2rgb(hsvImg));
output = hsvImg;
