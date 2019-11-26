function [constrain,mapXY,ellipse] = mainFunc(mapXY, startXY, destXY, color, radius)
%OUTPUTELLIPSE Summary of this function goes here
%   Detailed explanation goes here

% find a square search range
[xl,xh,yl,yh] = findSearchRange(startXY,destXY,mapXY.xLength, mapXY.yLength);
ellipse = {};
% find the a of the ellipse
a = distance(startXY,destXY)/2;
aSquare = a^2;
% find the center of the ellipse
cx = (startXY(1) + destXY(1))/2;
cy = (startXY(2) + destXY(2))/2;
% the minimum b square is smaller than a square
minbsquare = aSquare;
minx = 0;
miny = 0;
% find how the ellipse is turned from a standard ellipse, the turning angle
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

% draw the ellipse center and collision point
mapXY.cellStatus(minx,miny) = 3;
mapXY.cellStatus(ceil(cx),ceil(cy)) = 3;

ellipse{length(ellipse) + 1} = [a, sqrt(minbsquare), cos, sin, cx, cy];

% find the first tangentLine
[tl1a, tl1b, tl1c] = tangentLine(a^2,minbsquare,cos,sin,[minx,miny],[cx,cy]);

constrain = findSearchConstrain(startXY, destXY, radius);
constrain = [constrain ; tl1a, tl1b, tl1c];

hold on ;
% dynamic range
[sxl,sxh,syl,syh] = findSearchRangeDynamic(startXY,destXY,radius,mapXY.xLength,mapXY.yLength);
barriers = {} ;
for i = sxl : sxh
    for j = syl : syh
        if (mapXY.cellStatus(i,j) == 1 && ~mapXY.isInsideBlock(i,j) && isSameSide(constrain, [i,j], [cx,cy]))
            %             mapXY.cellStatus(i,j) = 3;
            barriers{length(barriers) + 1} = [i,j];
            mapXY.cellStatus(i,j) = 3;
        end
    end
end
% balloon
abratio = a / sqrt(minbsquare);
% lastB = sqrt(minbsquare);
% lastA = a;
while(~isempty(barriers))
    minPlace = 1;
    minx = barriers{1}(1);
    miny = barriers{1}(2);
    bsquare = findBSquareFixedABRatio(barriers{1}(1),barriers{1}(2),abratio,cos,sin,cx,cy);
    for i = 1 : length(barriers)
        tempPoint = barriers{i};
        tempBsq = findBSquareFixedABRatio(tempPoint(1),tempPoint(2),abratio,cos,sin,cx,cy);
        if (tempBsq < bsquare)
            bsquare = tempBsq;
            minx = tempPoint(1);
            miny = tempPoint(2);
            minPlace = i;
        end
    end
    mapXY.cellStatus(minx,miny) = 4;
    barriers(minPlace) = [];
    ellipse{length(ellipse) + 1} = [sqrt(abratio^2 * bsquare), sqrt(bsquare), cos,sin,cx,cy];
    [tla, tlb, tlc] = tangentLine(abratio^2 * bsquare,bsquare,cos,sin,[minx,miny],[cx,cy]);
    constrain = [constrain ; tla, tlb, tlc];
    
    % make sure b is getteing smaller
%     tempA = sqrt(abratio^2 * bsquare);
%     if (abs(sqrt(bsquare) - lastB) > 1 || abs(tempA - lastA) > 1)
%         lastB = sqrt(bsquare);
%         lastA = tempA;
%         ellipse{length(ellipse) + 1} = [sqrt(abratio^2 * bsquare), sqrt(bsquare), cos,sin,cx,cy];
%         [tla, tlb, tlc] = tangentLine(abratio^2 * bsquare,bsquare,cos,sin,[minx,miny],[cx,cy]);
%         constrain = [constrain ; tla, tlb, tlc];
%     end
    
    
    % delete points
%     fprintf('length of barriers before delete');
%     disp(length(barriers));
    j = 0;
    for i = 1 : length(barriers)
        if (~isSameSide(constrain, [cx,cy], barriers{i-j}))
            barriers(i - j) = [];
            j = j + 1;
        end
    end
    
%     if (j >= 0)
%         ellipse{length(ellipse) + 1} = [sqrt(abratio^2 * bsquare), sqrt(bsquare), cos,sin,cx,cy];
%         [tla, tlb, tlc] = tangentLine(abratio^2 * bsquare,bsquare,cos,sin,[minx,miny],[cx,cy]);
%         constrain = [constrain ; tla, tlb, tlc];
%     end
%     fprintf('num deleted');
%     disp(j);   
%     fprintf('length of barriers after delete');
%     disp(length(barriers));
    
end

% color the safe area
for i = sxl : sxh
    for j = syl : syh
        if ((mapXY.cellStatus(i,j) == 0 || mapXY.cellStatus(i,j) == 13) && isSameSide(constrain, [i,j], [cx,cy]))
            if (mapXY.cellStatus(i,j) == 0)
                mapXY.cellStatus(i,j) = 13;
            else
                mapXY.cellStatus(i,j) = 14;
            end
        end
    end
end

end

