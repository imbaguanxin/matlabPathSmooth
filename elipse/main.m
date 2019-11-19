% build map from img
img = imread('D:/repo/matlabPathSmooth/data/garageMap.jpg');
% img = imread('/Users/guanxin/Desktop/cloned/matlabPathSmooth/data/garageMap.jpg');
% change img from color to gray
img = rgb2gray(img);
[sizeRow, sizeCol] = size(img);
mapStatus = zeros(sizeRow,sizeCol);
for i = 1 : sizeRow
    for j = 1 : sizeCol
        temp = img(i,j);
        if ( i == 1 || j == 1 || temp < 128)
            mapStatus(i,j) = 1;
        end
    end
end
% build map
map = map2d(sizeRow,sizeCol);
map.cellStatus = mapStatus;

% build path
path = {[11,19],[90,120],[400,120],[750,120],[750,350]};

% set radius
radius = 50;

% set output picture size
picSize = 900;

% set visualization mode
% possible modes: 'ellipse-only', 'line-only', 'all'
% input other command will result in a map with safe areas without ellipse
% and lines.
visMode = 'ellipse-only';

% run the function, all constrain is stored
constrain = ellipseGenerateWrap(map,path,picSize,radius,visMode);