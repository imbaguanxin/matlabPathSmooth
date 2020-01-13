function result = map2d2mapXYcor(map)
%MAP2D2MAPXYCOR 此处显示有关此函数的摘要
%   此处显示详细说明
result = mapXYcor(map.colLength, map.rowLength);
for i = 1:map.rowLength
    for j = 1:map.colLength
        result.cellStatus(j,map.rowLength + 1 - i) = map.cellStatus(i,j);
        result.colorStatus(j,map.rowLength + 1 - i) = map.cellStatus(i,j);
    end
end

