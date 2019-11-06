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

path = {[11,19],[90,156],[90,426],[105,563],[475,569], [741,575]};

% build xy map (translate the coordinate
mapXY = map2d2mapXYcor(map);
mapElipse = mapXY;
mapConstrain = mapXY;

constrain = {};

for index = 1 : length(path) - 1
    startXY = map.pointToXYCor(path{index});
    destXY = map.pointToXYCor(path{index+1});
    [aSquare,bSquare,cos,sin,minx,miny,cx,cy,mapElipse] = mainFunc(mapElipse,startXY,destXY,index);
%     constrain{length(constrain) + 1} = [aSquare,bSquare,cos,sin,minx,miny,cx,cy];
end

img = mapElipse.showMapImg();
% imshow(img);

% % find search range related to dynamic constrains
% velocity = 10;
% acceleration = 2;
% % radius = velocity^2 / (2 * acceleration^2);
% % I just did a test so radius is arbitrarily set.
% radius = 200;
% 
% for index = 1: length(constrain)
%     aSquare = constrain{index}(1);
%     bSquare = constrain{index}(2);
%     cos = constrain{index}(3);
%     sin = constrain{index}(4);
%     minx = constrain{index}(5);
%     miny = constrain{index}(6);
%     cx = constrain{index}(7);
%     cy = constrain{index}(8);
%     
%     outPutConstrain(aSquare,bSquare,cos,sin,minx,miny,cx,cy,radius,mapConstrain);
% end

% 
% 
% % find the first tangentLine
% [tl1a, tl1b, tl1c] = tangentLine(a^2,minbsquare,cos,sin,[minx,miny],[cx,cy]);
% 
% % find search range related to dynamic constrains
% velocity = 10;
% acceleration = 2;
% % radius = velocity^2 / (2 * acceleration^2);
% radius = 200;
% constrain = findSearchConstrain(startXY, destXY, radius);
% constrain = [constrain ; tl1a, tl1b, tl1c];
% 
% 
% [sxl,sxh,syl,syh] = findSearchRangeDynamic(startXY,destXY,radius,mapXY.xLength,mapXY.yLength);
% barriers = {} ;
% for i = sxl : sxh
%     for j = syl : syh
%         if (mapXY.cellStatus(i,j) == 1 && ~mapXY.isInsideBlock(i,j) && ~isSameSide(constrain, [i,j], [cx,cy]))
%             barriers{length(barriers) + 1} = [i,j];
%         end
%     end
% end
% 
% abratio = a / sqrt(minbsquare);
%  while(~isempty(barriers))
%     minPlace = 1;
%     bsquare = findBSquareFixedABRatio(barriers{1}(1),barriers{1}(2),abratio,cos,sin);
%     for i = 1 : length(barriers)
%         tempPoint = barriers{i};
%         tempBsq = findBSquareFixedABRatio(tempPoint(1),tempPoint(2),abratio,cos,sin);
%         if (tempBsq < bsquare)
%             bsquare = tempBsq;
%             minx = tempPoint(1);
%             miny = tempPoint(2);
%         end
%     end
%     
%     [tla, tlb, tlc] = tangentLine(abratio^2 * bsquare,bsquare,cos,sin,[minx,miny],[cx,cy]);
%     
%     constrain = [constrain ; tla, tlb, tlc];
%     
%     barriers(minPlace) = [];
%     
%     % delete points
%     j = 0;
%     for i = 1 : length(barriers)
%         if (~isSameSide(constrain, [cx,cy], [i,j]))           
%             barriers(i - j) = [];
%             j = j + 1;
%         end
%     end
%  end
% 
% 
% % tlFunc = sprintf('%d * x + %d * y + ( %d)', tl1a, tl1b, tl1c);
% 
% % elipse = elipseFunc(cx,cy,a,sqrt(minbsquare),cos,sin);
% 
% % ezplot(elipse, [0,800]);
% % ezplot(tlFunc, [0,800]);
% 
% disp(constrain);
% 
% 
% 
% 
img = flip(img,1);
imshow( img ) ;
hold on ;
 
% set the range of the axes
% The image will be stretched to this.
min_x = 0;
max_x = 600;
min_y = 0;
max_y = 600;
 
% make data to plot - just a line.
x = min_x:max_x;
y = x;
plot(x,y,'b-*','linewidth',5);
set(gca,'ydir','normal'); 
