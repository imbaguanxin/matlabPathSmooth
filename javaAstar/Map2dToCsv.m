function csv = Map2dToCsv(map2d, fileName)
%WRITEMAPASTABLE Summary of this function goes here
%   Detailed explanation goes here
csv = map2d.cellStatus;
writematrix(map2d.cellStatus, fileName);
end

