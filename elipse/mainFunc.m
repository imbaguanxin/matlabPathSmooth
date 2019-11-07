function [constrain,mapXY,elipse] = mainFunc(mapXY, startXY, destXY, color, radius)
%OUTPUTELIPSE Summary of this function goes here
%   Detailed explanation goes here

% find a square search range
[xl,xh,yl,yh] = findSearchRange(startXY,destXY,mapXY.xLength, mapXY.yLength);
elipse = {};
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

% draw the elipse
% for i = xl : xh
%     for j = yl : yh
%         if (mapXY.cellStatus(i,j) == 0)
%             if (withInElipse([i,j],[cx,cy],a,sqrt(minbsquare),cos,sin))
%                 mapXY.cellStatus(i,j) = mod(color,10) + 3;
%             end
%         end
%     end
% end
mapXY.cellStatus(minx,miny) = 3;
mapXY.cellStatus(ceil(cx),ceil(cy)) = 3;

elipse{length(elipse) + 1} = [a, sqrt(minbsquare), cos, sin, cx, cy];

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
% fprintf('length of barriers');
% disp(length(barriers));

abratio = a / sqrt(minbsquare);
while(~isempty(barriers))
    minPlace = 1;
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
    elipse{length(elipse) + 1} = [sqrt(abratio^2 * bsquare), sqrt(bsquare), cos,sin,cx,cy];
    [tla, tlb, tlc] = tangentLine(abratio^2 * bsquare,bsquare,cos,sin,[minx,miny],[cx,cy]);
    
    constrain = [constrain ; tla, tlb, tlc];
    
    barriers(minPlace) = [];
    
    % delete points
    j = 0;
    for i = 1 : length(barriers)
        if (~isSameSide(constrain, [cx,cy], barriers{i-j}))
            barriers(i - j) = [];
            j = j + 1;
        end
    end
    %     fprintf('length of barriers');
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

% img = mapXY.showMapImg();
% img = flip(img,1);
% imshow( img ) ;

end

