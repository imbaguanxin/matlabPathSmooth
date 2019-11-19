function result = genHessenberg(inputT)
%GENHESSEN Summary of this function goes here
%   Detailed explanation goes here
result = zeros(10*length(inputT), 10*length(inputT));
for i = 1 : length(inputT)
    startIndex = (i-1) * 10;
    result(startIndex + 1, startIndex + 1) = inputT(i);
    result(startIndex + 2, startIndex + 2) = inputT(i) * 0.000001;
    result(startIndex + 3, startIndex + 3) = inputT(i) * 0.000001;
    result(startIndex + 4, startIndex + 4) = inputT(i) * 0.000001;
    result(startIndex + 5, startIndex + 5) = inputT(i) * 0.000001;
    result(startIndex + 6, startIndex + 6) = inputT(i);
    result(startIndex + 7, startIndex + 7) = inputT(i) * 0.000001;
    result(startIndex + 8, startIndex + 8) = inputT(i) * 0.000001;
    result(startIndex + 9, startIndex + 9) = inputT(i) * 0.000001;
    result(startIndex + 10, startIndex + 10) = inputT(i) * 0.000001;
end
end

