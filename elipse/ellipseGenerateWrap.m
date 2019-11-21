function constrain = ellipseGenerateWrap(map,path,drawSize,radius,mode)
%ELLIPSEGENERATEWRAP inputs a original map, path, the size of the
%final picture, the radius of dynamic constrain and how you want to
%visualize the map.
% mark the paths

mapXY = map2d2mapXYcor(map);
mapEllipse = mapXY;

constrain = cell(length(path) - 1,1);
allEllipse = cell(length(path) - 1,1);
hold on ;

% main loop that find the safe area
for index = 1 : length(path) - 1
    startXY = map.pointToXYCor(path{index});
    destXY = map.pointToXYCor(path{index+1});
    [lines,mapEllipse,ellipseStack] = mainFunc(mapEllipse,startXY,destXY,index,radius);
    allEllipse{index} = ellipseStack;
    constrain{index} = lines;
end



% show img with safe area
img = mapEllipse.showMapImg();
img = flip(img,1);
imshow( img ) ;
hold on ;

% draw
switch mode
    case 'line-only'
        % draw line
        for i = 1 : length(constrain)
            row = size(constrain{i});
            for j = 1 : row
                temp = constrain{i}(j,:);
                drawLine(temp(1),temp(2),temp(3));
            end
        end
    case 'ellipse-only'
        % draw ellipses
        for i = 1 : length(allEllipse)
            row = size(allEllipse{i});
            for j = 1 : row
                temp = allEllipse{i};
                for k = 1 : length(temp)
                    pic = temp{k};
                    drawEllipse(pic(1),pic(2),pic(3),pic(4),pic(5),pic(6));
                end
            end
        end
    case 'all'
        for i = 1 : length(constrain)
            row = size(constrain{i});
            for j = 1 : row
                temp = constrain{i}(j,:);
                drawLine(temp(1),temp(2),temp(3));
            end
        end
        for i = 1 : length(allEllipse)
            row = size(allEllipse{i});
            for j = 1 : row
                temp = allEllipse{i};
                for k = 1 : length(temp)
                    pic = temp{k};
                    drawEllipse(pic(1),pic(2),pic(3),pic(4),pic(5),pic(6));
                end
            end
        end
    otherwise
end

% mark the paths
for i = 1 : length(path)
    pt = map.pointToXYCor(path{i});
    plot(pt(1),pt(2),'o');
    hold on;
end

xlim([0 drawSize])
ylim([0,drawSize])
set(gca,'ydir','normal');
hold on
end

