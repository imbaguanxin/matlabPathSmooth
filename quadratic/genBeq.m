function result = genBeq(inputPath)
%GENBEQ Summary of this function goes here
%   Detailed explanation goes here
if(length(inputPath) < 3)
    fprintf("length of the input Path should > 2, your input:");
    disp(length(inputPath));
end
totalLength = (length(inputPath) - 2) * 8 + 4;
% totalLength = (length(inputPath) - 2) * 8 + (length(inputPath) - 1)*4;
result = zeros(totalLength,1);
% j = 1;
% for i = 1 : length(inputPath)
%     tempPoint = inputPath{i};
%     if (i == 1)
%         result(j) = tempPoint(1);
%         result(j+1) = tempPoint(2);
%         j = j+2;
%     elseif (i == length(inputPath))
%         result(j) = tempPoint(1);
%         result(j+1) = tempPoint(2);
%     else
%         result(j) = tempPoint(1);
%         result(j+1) = tempPoint(2);
%         result(j+2) = tempPoint(1);
%         result(j+3) = tempPoint(2);
%         j = j+4;
%     end
% end
firstPoint = inputPath{1};
result(1) = firstPoint(1);
result(2) = firstPoint(2);
lastPoint = inputPath{length(inputPath)};
result(3) = lastPoint(1);
result(4) = lastPoint(2);
end





% totalLength = length(inputPath) * 8 + 4;
% result = zeros(totalLength,1);
% firstPoint = inputPath(1);
% result(1) = firstPoint(1);
% result(2) = firstPoint(1);
% pointPartCenter = zeros(length(inputPath) * 4, 1);
% currentPosition = 1;
% for i = 2:length(inputPath)-1
%     tempPoint = inputPath(i);
%     pointPartCenter(currentPosition) = tempPoint(1);
%     pointPartCenter(currentPosition+1) = tempPoint(2);
%     pointPartCenter(currentPosition+2) = tempPoint(1);
%     pointPartCenter(currentPosition+3) = tempPoint(2);
% end
% result = pointPartCenter;
