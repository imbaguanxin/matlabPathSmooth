function constrain = outPutConstrain(aSquare,bSquare,cos,sin,minx,miny,cx,cy,radius,mapXY)
%OUTPUTCONSTRAIN Summary of this function goes here
%   Detailed explanation goes here
% find the first tangentLine
[tl1a, tl1b, tl1c] = tangentLine(aSquare,bSquare,cos,sin,[minx,miny],[cx,cy]);

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

abratio = sqrt(aSquare) / sqrt(bSquare);
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

end

