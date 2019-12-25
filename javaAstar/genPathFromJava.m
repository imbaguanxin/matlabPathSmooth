function path = genPathFromJava(fn)
%GENPATHFROMJAVA Summary of this function goes here
%   Detailed explanation goes here
csv = csvread(fn,1);
[row, col] = size(csv);
path = cell(1, row);
for i = 1 : row
    path{i} = csv(i,:);
end
end

