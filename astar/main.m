% build map
sizeRow = 600;
sizeCol = 600;
mapStatus = zeros(sizeRow, sizeCol);
mapStatus(1,:) = 1;
mapStatus(:,1) = 1;
mapStatus(600,:) = 1;
mapStatus(:,600) = 1;

% map 1 no balloon
% mapStatus(400:500, 100:200) = 1;
% mapStatus(450:550, 350:450) = 1;
% mapStatus(200:300, 200:300) = 1;
% mapStatus(50:150, 50:150) = 1;
% mapStatus(100:320, 500:600) = 1;

% map 2 balloon
mapStatus(380:520, 80:220) = 1;
mapStatus(430:570, 330:470) = 1;
mapStatus(180:320, 180:320) = 1;
mapStatus(30:170, 30:170) = 1;
mapStatus(80:340, 480:620) = 1;

map = map2d(sizeRow,sizeCol);
map.cellStatus = mapStatus;

startPoint = [20,20];
endPoint = [570,570];
scoreFlag = 'diagnoal';
logName = 'astar_result_map_b.csv';

[pathresult, imgResult] = astar(map, startPoint, endPoint, scoreFlag, logName);