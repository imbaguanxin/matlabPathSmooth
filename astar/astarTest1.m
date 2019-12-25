map = mapBuilding();

rowSize = map.rowLength;
colSize = map.colLength;

Map2dToCsv(map, 'FFmap.csv');

startPoint = [25,25];
endPoint = [575,575];

% astarNew(map, startPoint, endPoint, "diagonal", "astar_test_1", 1);