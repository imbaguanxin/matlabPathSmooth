% ezplot(func, [-5,5])

% build map from img
% img = imread('D:/repo/matlabPathSmooth/data/garageMap.jpg');
img = imread('/Users/guanxin/Desktop/cloned/matlabPathSmooth/data/garageMap.jpg');
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

start = [30,30];
dest = [90,156];

% build xy map (translate the coordinate
mapXY = map2d2mapXYcor(map);
startXY = [start(2), map.rowLength + 1 - start(1)];
destXY = [dest(2), map.rowLength + 1 - dest(1)];


% CALCULATE ELIPSE

% find a square search range
[xl,xh,yl,yh] = findSearchRange(startXY,destXY,mapXY.xLength, mapXY.yLength);

% find the a of the elipse
a = distance(startXY,destXY)/2;
% find the center of the elipse
cx = (startXY(1) + destXY(1))/2;
cy = (startXY(2) + destXY(2))/2;
% the minimum b square is smaller than a square
minbsquare = a^2;
minx = 0;
miny = 0;
% find how the elipse is turned from a standard elipse
% sin <- sin(-theta), cos <- cos(-theta)
[sin,cos] = findFinalSinCos(startXY, destXY);

% search in the range
for i = xl : xh
    for j = yl : yh
        % if some point is blocked, not in the middle of some barrier,
        % isInRange assures that the distance from (i,j) to center less
        % than a.
        if (mapXY.cellStatus(i,j) == 1 && ~mapXY.isInsideBlock(i,j) && isInRange(startXY,destXY,[i,j]))
            tempBsq = findBSquare(i-cx, j-cy ,a, sin, cos);
%             disp(tempBsq);
            % find the smallest b square
            if (tempBsq < minbsquare)
                minbsquare = tempBsq;
                minx = i;
                miny = j;
            end
        end
    end
end

% draw the elipse
for i = xl : xh
    for j = yl : yh
        if (mapXY.cellStatus(i,j) == 0)
            if (withInElipse([i,j],[cx,cy],a,sqrt(minbsquare),cos,sin))
                mapXY.cellStatus(i,j) = 5;
            end
        end
    end
end
mapXY.cellStatus(minx,miny) = 3;
mapXY.cellStatus(cx,cy) = 3;
imgResult = mapXY.showMapImg();
imshow(imgResult);


% find the first tangentLine
[tangentLine1a, tangentLine1b, tangentLine1c] = tangentLine(a^2,minbsquare,cos,sin,[minx,miny],[cx,cy]);

tlFunc = sprintf('%d * x + %d * y + ( %d)', tangentLine1a,tangentLine1b,tangentLine1c);
elipseFunc = sprintf('((x - %d) * %d - (y - %d) * %d)^2 / %d^2 + ((x - %d) * %d + (y - %d) * %d)^2 / %d^2 - 1', cx,cos,cy,sin,a,cx,sin,cy,cos,sqrt(minbsquare));
comb = sprintf('%s * %s', tlFunc, elipseFunc);
% line = sprintf('%d * x + %d * y + %d = 0', a,b,c);
% line2 = sprintf('%d * x + %d * y + %d = 0', aa,bb,cc);
% lines = sprintf('(%d * x + %d * y + %d) * (%d * x + %d * y + %d)', aa,bb,cc,a,b,c);
% 
% ezplot(elipseFunc, [0,800]);
ezplot(tlFunc, [0,800]);






