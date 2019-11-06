% ezplot(func, [-5,5])

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
% find how the elipse is turned from a standard elipse, the turning angle
% is theta.
% sin means sin(-theta), cos means cos(-theta)
[sin,cos] = findFinalSinCos(startXY, destXY);

% search in the range
for i = xl : xh
    for j = yl : yh
        % if some point is blocked, not in the middle of some barrier,
        % isInRange assures that the distance from (i,j) to center less
        % than a.
        if (mapXY.cellStatus(i,j) == 1 && ~mapXY.isInsideBlock(i,j) && isInRange(startXY,destXY,[i,j]))
            tempBsq = findBSquare(i-cx, j-cy ,a, cos, sin);
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
[tl1a, tl1b, tl1c] = tangentLine(a^2,minbsquare,cos,sin,[minx,miny],[cx,cy]);

% find search range related to dynamic constrains
velocity = 10;
acceleration = 2;
% radius = velocity^2 / (2 * acceleration^2);
radius = 200;
constrain = findSearchConstrain(startXY, destXY, radius);
constrain = [constrain ; tl1a, tl1b, tl1c];


[sxl,sxh,syl,syh] = findSearchRangeDynamic(startXY,destXY,radius,mapXY.xLength,mapXY.yLength);
barriers = {} ;
for i = sxl : sxh
    for j = syl : syh
        if (mapXY.cellStatus(i,j) == 1 && ~mapXY.isInsideBlock(i,j) && ~isSameSide(constrain, [i,j], [cx,cy]))
            barriers{length(barriers) + 1} = [i,j];
        end
    end
end

abratio = a / sqrt(minbsquare);
 while(~isempty(barriers))
    minPlace = 1;
    bsquare = findBSquareFixedABRatio(barriers{1}(1),barriers{1}(2),abratio,cos,sin);
    for i = 1 : length(barriers)
        tempPoint = barriers{i};
        tempBsq = findBSquareFixedABRatio(tempPoint(1),tempPoint(2),abratio,cos,sin);
        if (tempBsq < bsquare)
            bsquare = tempBsq;
            minx = tempPoint(1);
            miny = tempPoint(2);
        end
    end
    
    [tla, tlb, tlc] = tangentLine(abratio^2 * bsquare,bsquare,cos,sin,[minx,miny],[cx,cy]);
    
    constrain = [constrain ; tla, tlb, tlc];
    
    barriers(minPlace) = [];
    
    % delete points
    j = 0;
    for i = 1 : length(barriers)
        if (~isSameSide(constrain, [cx,cy], [i,j]))           
            barriers(i - j) = [];
            j = j + 1;
        end
    end
 end


% tlFunc = sprintf('%d * x + %d * y + ( %d)', tl1a, tl1b, tl1c);

% elipse = elipseFunc(cx,cy,a,sqrt(minbsquare),cos,sin);

% ezplot(elipse, [0,800]);
% ezplot(tlFunc, [0,800]);

disp(constrain);




