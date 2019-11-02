% p1 = [-1,sqrt(3)];
% p2 = [1,-sqrt(3)];
% [sin,cos] = findFinalSinCos(p1,p2);

% asquare = 5^2;
% bsquare = 1^2;
% func = sprintf('(x * %d - y * %d)^2 / %d + (x * %d + y * %d)^2/%d - 1', cos,sin,asquare, sin,cos,bsquare);
% ezplot(func, [-5,5])

% build map
img = imread('D:/repo/matlabPathSmooth/data/garageMap.jpg');
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
map = map2d(sizeRow,sizeCol);
map.cellStatus = mapStatus;

start = [30,30];
dest = [90,156];

[xl,xh,yl,yh] = findSearchRange(start,dest,map.rowLength, map.colLength);

% disp([xl,xh,yl,yh]);

a = distance(start,dest)/2;
cx = (start(1) + dest(1))/2;
cy = (start(2) + dest(2))/2;
minbsquare = a^2;
minx = 0;
miny = 0;
[sin,cos] = findFinalSinCos(start, dest, map.rowLength);
for i = xl : xh
    for j = yl : yh
        if (map.cellStatus(i,j) == 1 && ~map.isInsideBlock(i,j) && isInRange(start,dest,[i,j]))
            tempBsq = findBSquare(j - cy, cx - i ,a, sin, cos);
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
        if (map.cellStatus(i,j) == 0)
            if (withInElipse([i,j],[cx,cy],a,sqrt(minbsquare),cos,sin))
                disp(i);
                disp(j);
                map.cellStatus(i,j) = 5;
            end
        end
    end
end

imgResult = showMapImg(map);
imgResult(minx,miny,:) = [102/255,204/255,255/255];
imgResult(minx-1,miny,:) = [102/255,204/255,255/255];
imgResult(minx+1,miny,:) = [102/255,204/255,255/255];
imgResult(minx,miny-1,:) = [102/255,204/255,255/255];
imgResult(minx,miny+1,:) = [102/255,204/255,255/255];
imgResult(dest(1),dest(2),:) = [160/255,32/255,240/255];
imgResult(start(1),start(2),:) = [160/255,32/255,240/255];
imshow(imgResult);


