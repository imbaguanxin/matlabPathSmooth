%%
clc;
clear all;
close all;
% build map
sizeRow = 600;
sizeCol = 600;
mapStatus = zeros(sizeRow, sizeCol);
mapStatus(1,:) = 1;
mapStatus(:,1) = 1;
mapStatus(600,:) = 1;
mapStatus(:,600) = 1;
% map 4
mapStatus(51:150, 50:300) = 1;
mapStatus(451:550, 50:300) = 1;
mapStatus(151:450, 200:300) = 1;
mapStatus(151:250, 50:150) = 1;
mapStatus(351:450, 50:150) = 1;
mapStatus(151:250, 350:550) = 1;
mapStatus(251:350, 450:550) = 1;
mapStatus(351:450, 350:550) = 1;
mapStatus(551:600, 200:300) = 1;
mapStatus(1:150, 451:550) = 1;
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
mapStatusBallooned(41:160, 40:310) = 1;
mapStatusBallooned(441:560, 40:310) = 1;
mapStatusBallooned(141:460, 190:310) = 1;
mapStatusBallooned(141:260, 40:160) = 1;
mapStatusBallooned(341:460, 40:160) = 1;
mapStatusBallooned(141:260, 340:560) = 1;
mapStatusBallooned(241:360, 440:560) = 1;
mapStatusBallooned(341:460, 340:560) = 1;
mapStatusBallooned(541:600, 190:310) = 1;
mapStatusBallooned(1:160, 441:560) = 1;
mapBallooned = map2d(sizeRow,sizeCol);
mapBallooned.cellStatus = mapStatusBallooned;
figure;
img = mapBallooned.showMapMatrixImg();
imshow(img);
%% generate astar on origin map
% build path
% startPoint = [250,25];
% endPoint = [350,575];
% scoreFlag = 'diagonal';%'manhattan';
% logFileName = 'realexpMap4-astar.csv';
% gridSize = 1;
% figure;
% [path_mat, imgResult] = astarNew(map,startPoint, endPoint, scoreFlag, logFileName, gridSize);
% x = path_mat(:,1);
% y = path_mat(:,2);
% hold on;
% plot(y, x);
%% generate astar ballooned map:
% startPoint = [250,25];
% endPoint = [350,575];
% scoreFlag = 'diagonal';
% logFileName = 'realexpMap4Ballooned-astar.csv';
% gridSize = 1;
% figure;
% [path_mat, imgResult] = astarNew(mapBallooned,startPoint, endPoint, scoreFlag, logFileName, gridSize);
% x = path_mat(:,1);
% y = path_mat(:,2);
% hold on;
% plot(y, x);
%% find selected path for path smooth
logFileName = 'realexpMap4Ballooned-astar.csv';
path = csvPathSelectGuan(logFileName);
path(7) = [];
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
[r,A,B,time,initState] = mainConstraint(newCons, newPath, amax, vmax, 3, true, 3, maxIter);
% disp(r);
dt = 0.1;
mat = plotSmoothPath(time, r, dt, false);
% disp(mat);
 
% format long g; % no scientific notation
fid = fopen('realExpriment4-smooth.csv', 'w');
legend = {'time', 'x', 'y' ,'vx', 'vy'};
fprintf(fid, '%s,%s,%s,%s,%s\n', legend{:});
for i = 1: length(mat)
    [row,col] = size(mat{i});
    for j = 1: row
        fprintf(fid, '%3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', mat{i}(j,:));
    end
end