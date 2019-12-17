img = imread('../data/garageMap.jpg');
img = rgb2gray(img);
[sizeRow, sizeCol] = size(img);
mapStatus = zeros(sizeRow,sizeCol);
for i = 1 : sizeRow
    for j = 1 : sizeCol
        temp = img(i,j);
        if (temp < 128)
            mapStatus(i,j) = 1;
        end
    end
end

% 
map = map2d(sizeRow,sizeCol);
map.cellStatus = mapStatus;
% map.cellStatus = [0,0,0,0,0,0,0,0,1,0,0,0,0,0;
%                   0,0,1,0,0,0,0,0,1,0,0,0,0,0;
%                   0,0,1,1,1,1,1,0,1,0,0,0,0,0;
%                   0,1,1,1,1,0,0,0,1,0,0,0,0,0;
%                   0,0,1,1,1,0,0,1,1,1,1,1,1,1;
%                   0,0,0,0,0,0,0,0,0,0,0,0,0,0;
%                   0,0,1,0,1,0,0,0,0,0,0,0,0,0;
%                   0,1,1,1,0,1,0,1,1,1,1,1,1,1;
%                   0,0,0,1,0,0,0,0,0,0,0,0,0,0;
%                   0,1,1,1,0,0,1,1,1,1,1,1,0,0;
%                   0,0,0,1,0,0,1,0,0,0,0,1,0,0;
%                   1,1,1,1,0,0,1,0,1,0,0,1,0,0;
%                   0,0,0,0,0,0,0,0,1,0,0,1,0,0];
% map status: 0 - blank, 1 - obstacle, 3 - searched, 4 - path


% manually alloacate the startpoint and endpoint
startPoint = [12,13];
endPoint = [675,593];
% endPoint = [780,300];
% endPoint = [200,100];

% f+g : diagonal / cartesian
scoreFlag = 'diagnoal';
logName = 'matlabAstar.csv';
gridSize = 1;
[pathresult, imgResult] = astar(map, startPoint, endPoint, scoreFlag, logName, gridSize);

