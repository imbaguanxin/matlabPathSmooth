function [aSquare,bSquare,cos,sin,minx,miny,cx,cy,mapXY] = mainFunc(mapXY, startXY, destXY, color)
%OUTPUTELIPSE Summary of this function goes here
%   Detailed explanation goes here

% find a square search range
[xl,xh,yl,yh] = findSearchRange(startXY,destXY,mapXY.xLength, mapXY.yLength);

% find the a of the elipse
a = distance(startXY,destXY)/2;
aSquare = a^2;
% find the center of the elipse
cx = (startXY(1) + destXY(1))/2;
cy = (startXY(2) + destXY(2))/2;
% the minimum b square is smaller than a square
minbsquare = aSquare;
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

bSquare = minbsquare;


% draw the elipse
for i = xl : xh
    for j = yl : yh
        if (mapXY.cellStatus(i,j) == 0)
            if (withInElipse([i,j],[cx,cy],a,sqrt(minbsquare),cos,sin))
                mapXY.cellStatus(i,j) = mod(color,10) + 3;
            end
        end
    end
end
mapXY.cellStatus(minx,miny) = 3;
mapXY.cellStatus(ceil(cx),ceil(cy)) = 3;

end

