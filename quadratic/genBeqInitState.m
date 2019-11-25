function result = genBeqInitState(inputPath,initVx, initVy, initAx, initAy)
%GENBEQ Summary of this function goes here
%   Detailed explanation goes here
if(length(inputPath) < 3)
    fprintf("length of the input Path should > 2, your input:");
    disp(length(inputPath));
end
totalLength = (length(inputPath) - 2) * 8 + 4 + 4;
result = zeros(totalLength,1);
firstPoint = inputPath{1};
result(1) = firstPoint(1);
result(2) = firstPoint(2);
lastPoint = inputPath{length(inputPath)};
result(3) = lastPoint(1);
result(4) = lastPoint(2);
result(5) = initVx;
result(6) = initVy;
result(7) = initAx;
result(8) = initAy;
end