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

% build path
path = {[11,19],[90,120],[400,120],[750,120],[750,350],[500,340]};
% path = {[500,340],[750,350],[750,120],[400,120],[90,120],[11,19]};
% set radius
radius = 50;

% set output picture size
picSize = 900;

% set visualization mode
% possible modes: 'ellipse-only', 'line-only', 'all'
% input other command will result in a map with safe areas without ellipse
% and lines.
visMode = 'ellipse-only';
% visMode = 'line-only';
% run the function, all constrain is stored
constraints = ellipseGenerateWrap(map,path,picSize,radius,visMode);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% auto part

newCons = constraints(1:4);
newPath = path(1:5);
newPath = transCorList(newPath,map);

vmax = 13;
amax = 3;
% [r,A,B,time,initState] = mainConstraint(newCons, newPath, amax, vmax);
disp(r);
plotSmoothPath(time, r);

% newCons = constraints(4:5);
% newPath = path(4:6);
% [r1,A,B,time1,state] = mainConstraintInitState(newCons, newPath, map, amax, vmax, initState);
% plotSmoothPath(time1, r1);


% x to t, y to t velocity
% t = 0:0.1:15;
% x = z(1) * 4 * t.^3 + z(2) * 3 * t.^2 + z(3) * 2 * t + z(4);
% y = z(6) * 4 * t.^3 + z(7) * 3 * t.^2 + z(8) * 2 * t + z(9);
% plot(t,x);
% hold on;
% plot(t,y);

% x to t, y to t acceleration
% t = 0:0.1:15;
% x = z(1) * 12 * t.^2 + z(2) * 6 * t.^2 + z(3) * 2;
% y = z(6) * 12 * t.^2 + z(7) * 6 * t.^2 + z(8) * 2;
% plot(t,x);
% hold on;
% plot(t,y);

% x to t, y to t jerk
% t = 0:0.1:15; 
% x = z(1) * 24 * t.^1 + z(2) * 6;
% y = z(6) * 24 * t.^1 + z(7) * 6;
% plot(t,x);
% hold on;
% plot(t,y);