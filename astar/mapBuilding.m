function map = mapBuilding()
% build map
sizeRow = 600;
sizeCol = 600;
mapStatus = zeros(sizeRow, sizeCol);
mapStatus(1,:) = 1;
mapStatus(:,1) = 1;
mapStatus(600,:) = 1;
mapStatus(:,600) = 1;
% map 4
mapStatus(51:150, 50:300) = 1;
mapStatus(451:550, 50:300) = 1;
mapStatus(151:450, 200:300) = 1;
mapStatus(151:250, 50:150) = 1;
mapStatus(351:450, 50:150) = 1;
mapStatus(151:250, 350:550) = 1;
mapStatus(251:350, 450:550) = 1;
mapStatus(351:450, 350:550) = 1;
mapStatus(551:600, 200:300) = 1;
mapStatus(1:150, 451:550) = 1;
map = map2d(sizeRow,sizeCol);
map.cellStatus = mapStatus;
img = map.showMapMatrixImg();
imshow(img);
end

