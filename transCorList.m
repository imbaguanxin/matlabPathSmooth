function result = transCorList(pathList, map)
%TRANSCORLIST Summary of this function goes here
%   Detailed explanation goes here
    % transform corrdinates
result = cell(length(pathList),1);
for i = 1 : length(pathList)
    pt = map.pointToXYCor(pathList{i});
    result{i} = pt;
end
end

