function result = genH(tList)
%GENH Summary of this function goes here
%   Detailed explanation goes here
numOfPara = 6 * 2;
result = zeros(numOfPara * length(tList));
for i = 1 : length(tList)
    startIndex = numOfPara * (i - 1) + 1;
    result(startIndex,startIndex) = tList(i)^3 * 25 / 3;
    result(startIndex+1,startIndex) = tList(i)^2 * 25 / 2;
    result(startIndex,startIndex+1) = tList(i)^2 * 25 / 2;
    result(startIndex+1,startIndex+1) = tList(i);
    result(startIndex + numOfPara / 2,startIndex + numOfPara / 2) = tList(i)^3 * 25 / 3;
    result(startIndex + numOfPara / 2 + 1,startIndex + numOfPara / 2) = tList(i)^2 * 25 / 2;
    result(startIndex + numOfPara / 2,startIndex + numOfPara / 2 + 1) = tList(i)^2 * 25 / 2;
    result(startIndex + numOfPara / 2 + 1,startIndex + numOfPara / 2 + 1) = tList(i);  
end
end

