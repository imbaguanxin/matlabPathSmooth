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

% build xy map
mapXY = map2d2mapXYcor(map);
startXY = [start(2), map.rowLength + 1 - start(1)];
destXY = [dest(2), map.rowLength + 1 - dest(1)];


% calculate elipse
[xl,xh,yl,yh] = findSearchRange(startXY,destXY,mapXY.xLength, mapXY.yLength);

a = distance(startXY,destXY)/2;
cx = (startXY(1) + destXY(1))/2;
cy = (startXY(2) + destXY(2))/2;
minbsquare = a^2;
minx = 0;
miny = 0;
[sin,cos] = findFinalSinCos(startXY, destXY);

for i = xl : xh
    for j = yl : yh
        if (mapXY.cellStatus(i,j) == 1 && ~mapXY.isInsideBlock(i,j) && isInRange(startXY,destXY,[i,j]))
            tempBsq = findBSquare(i-cx, j-cy ,a, sin, cos);
            disp(tempBsq);
            if (tempBsq < minbsquare)
                minbsquare = tempBsq;
                minx = i;
                miny = j;
            end
        end
    end
end

for i = xl : xh
    for j = yl : yh
        if (mapXY.cellStatus(i,j) == 0)
            if (withInElipse([i,j],[cx,cy],a,sqrt(minbsquare),cos,sin))
                mapXY.cellStatus(i,j) = 5;
            end
        end
    end
end

imgResult = mapXY.showMapImg();
% imgResult(minx,miny,:) = [160/255,32/255,240/255];
% imgResult(minx-1,miny,:) = [160/255,32/255,240/255];
% imgResult(minx+1,miny,:) = [160/255,32/255,240/255];
% imgResult(minx,miny-1,:) = [160/255,32/255,240/255];
% imgResult(minx,miny+1,:) = [160/255,32/255,240/255];
% imgResult(dest(1),dest(2),:) = [160/255,32/255,240/255];
% imgResult(start(1),start(2),:) = [160/255,32/255,240/255];
imshow(imgResult);



