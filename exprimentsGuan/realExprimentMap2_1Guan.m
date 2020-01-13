%%
clc;
close all;
clear all;
% build map
sizeRow = 600;
sizeCol = 600;
mapStatus = zeros(sizeRow, sizeCol);
mapStatus(1,:) = 1;
mapStatus(:,1) = 1;
mapStatus(600,:) = 1;
mapStatus(:,600) = 1;
% map 2
mapStatus(100:200, 100:200) = 1;
mapStatus(250:350, 250:350) = 1;
mapStatus(400:500, 400:500) = 1;
mapStatus(400:500, 100:200) = 1;
mapStatus(250:350, 100:200) = 1;
mapStatus(400:500, 250:350) = 1;

mapStatus(100:200, 300:400) = 1;
mapStatus(100:300, 400:500) = 1;
map = map2d(sizeRow,sizeCol);
map.cellStatus = mapStatus;
img = map.showMapMatrixImg();
imshow(img);

%%
% map 2 ballooned
mapStatusBallooned = zeros(sizeRow, sizeCol);
mapStatusBallooned(1,:) = 1;
mapStatusBallooned(:,1) = 1;
mapStatusBallooned(600,:) = 1;
mapStatusBallooned(:,600) = 1;
mapStatusBallooned(90:210, 90:210) = 1;
mapStatusBallooned(240:360, 240:360) = 1;
mapStatusBallooned(390:510, 390:510) = 1;
mapStatusBallooned(390:510, 90:210) = 1;
mapStatusBallooned(240:360, 90:210) = 1;
mapStatusBallooned(390:510, 240:360) = 1;

mapStatusBallooned(90:210, 290:410) = 1;
mapStatusBallooned(90:310, 390:510) = 1;

mapBallooned = map2d(sizeRow,sizeCol);
mapBallooned.cellStatus = mapStatusBallooned;
figure;
img = mapBallooned.showMapMatrixImg();
imshow(img);

%% generate astar on origin map
% build path
% startPoint = [25,25];
% endPoint = [575,575];
% scoreFlag = 'diagonal';%'manhattan';
% logFileName = 'realexpMap2-astar.csv';
% gridSize = 1;
% figure;
% [path_mat, imgResult] = astarNew(map,startPoint, endPoint, scoreFlag, logFileName, gridSize);
% x = path_mat(:,1);
% y = path_mat(:,2);
% hold on;
% plot(y, x);
%% generate astar ballooned map:
% startPoint = [25,25];
% endPoint = [575,575];
% scoreFlag = 'diagonal';
% logFileName = 'realexpMap2Ballooned-astar.csv';
% gridSize = 1;
% figure;
% [path_mat, imgResult] = astarNew(mapBallooned,startPoint, endPoint, scoreFlag, logFileName, gridSize);
% x = path_mat(:,1);
% y = path_mat(:,2);
% hold on;
% plot(y, x);
%% find selected path for path smooth
logFileName = 'realexpMap2Ballooned-astar.csv';
path = csvPathSelectGuan(logFileName);
path{8} = [375,468];
x = [];
y = [];
for i = 1 : length(path)
    x = [x; path{i}(1)];
    y = [y; path{i}(2)];
end
hold on;

plot(y, x);

% set radius
radius = 40;

% set output picture size
picSize = 800;

% set visualization mode
% possible modes: 'ellipse-only', 'line-only', 'all'
% input other command will result in a map with safe areas without ellipse
% and lines.
% visMode = 'ellipse-only';
% visMode = 'line-only';
visMode = '';
% run the function, all constrain is stored
constraints = ellipseGenerateWrap(map,path,picSize,radius,visMode);

% constraints = constraintsSelector(constraints);

%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% auto part

newCons = constraints;
newPath = path;
disp(newPath);
newPath = transCorList(newPath,map);

vmax = 100;
amax = 50;
maxIter = 10000;
% timeInterval = zeros(1,length(newCons));
% for i = 1 : length(timeInterval)
%     timeInterval(i) = 3;
% end
% manually adjust time of each segment.
% [r,A,B,time,initState] = mainConstraintTime(newCons, newPath, amax, vmax, 20, timeInterval, maxIter);
[r,A,B,time,initState] = mainConstraint(newCons, newPath, amax, vmax, 2, true, 2, maxIter);
% disp(r);
dt = 0.1;
mat = plotSmoothPath(time, r, dt, false);
disp(mat);
 
% format long g; % no scientific notation
fid = fopen('realExpriment2-1-smooth.csv', 'w');
legend = {'time', 'x', 'y' ,'vx', 'vy'};
fprintf(fid, '%s,%s,%s,%s,%s\n', legend{:});
for i = 1: length(mat)
    [row,col] = size(mat{i});
    for j = 1: row
        fprintf(fid, '%3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', mat{i}(j,:));
    end
end