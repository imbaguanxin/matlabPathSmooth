% % build map from img
% img = imread('D:/repo/matlabPathSmooth/data/garageMap.jpg');
% 
% img = rgb2gray(img);
% [sizeRow, sizeCol] = size(img);
% mapStatus = zeros(sizeRow,sizeCol);
% for i = 1 : sizeRow
%     for j = 1 : sizeCol
%         temp = img(i,j);
%         if ( i == 1 || j == 1 || temp < 128)
%             mapStatus(i,j) = 1;
%         end
%     end
% end
% % build map
% map = map2d(sizeRow,sizeCol);
% map.cellStatus = mapStatus;
% 
% % build xy map (translate the coordinate
% mapXY = map2d2mapXYcor(map);
% 
% for i = 1 : mapXY.xLength
%     