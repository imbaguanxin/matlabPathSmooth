function result = transCorList(pathList, map)
%TRANSCORLIST transform corrdinates from image to normal
    % transform corrdinates
result = cell(length(pathList),1);
for i = 1 : length(pathList)
    pt = map.pointToXYCor(pathList{i});
    result{i} = pt;
end
end

