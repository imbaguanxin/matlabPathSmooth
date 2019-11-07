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

% path = {[11,19],[90,156],[90,426],[105,563],[475,569],[741,575]};

path = {[11,19],[90,156],[90,426],[105,563],[475,569],[741,575]};

% build xy map (translate the coordinate
mapXY = map2d2mapXYcor(map);
mapElipse = mapXY;
mapConstrain = mapXY;

constrain = cell(length(path) - 1);
allElipse = cell(length(path) - 1);
% find search range related to dynamic constrains
velocity = 10;
acceleration = 2;
% radius = velocity^2 / (2 * acceleration^2);
% I just did a test so radius is arbitrarily set.
radius = 50;
hold on ;

% main loop that find the safe area
for index = 1 : length(path) - 1
    startXY = map.pointToXYCor(path{index});
    destXY = map.pointToXYCor(path{index+1});
    [lines,mapElipse,elipseStack] = mainFunc(mapElipse,startXY,destXY,index,radius);
    allElipse{index} = elipseStack;
    constrain{index} = lines;
end

% show img with safe area
img = mapElipse.showMapImg();
img = flip(img,1);
imshow( img ) ;
hold on ;

% draw
for i = 1 : length(constrain)
    % draw line
    [row,col] = size(constrain{i});
    for j = 1 : row
        temp = constrain{i}(j,:);
        drawLine(temp(1),temp(2),temp(3));
    end
    % draw elipse
    [row,col] = size(allElipse{i});
    for j = 1 : row
        temp = allElipse{i};
        for k = 1 : length(temp)
            pic = temp{k};
            drawElipse(pic(1),pic(2),pic(3),pic(4),pic(5),pic(6));
        end
    end
end
xlim([0 900])
ylim([0,900])
set(gca,'ydir','normal'); 
