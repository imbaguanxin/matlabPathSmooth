%%
clear all;
clc;
close all;
% build map
sizeRow = 600;
sizeCol = 600;
mapStatus = zeros(sizeRow, sizeCol);
mapStatus(1,:) = 1;
mapStatus(:,1) = 1;
mapStatus(600,:) = 1;
mapStatus(:,600) = 1;
% map 1
mapStatus(400:500, 100:200) = 1;
mapStatus(450:550, 350:450) = 1;
mapStatus(200:300, 200:300) = 1;
mapStatus(50:150, 50:150) = 1;
mapStatus(100:320, 500:600) = 1;
map = map2d(sizeRow,sizeCol);
map.cellStatus = mapStatus;
%%
% map 2 ballooned
mapStatusBallooned = zeros(sizeRow, sizeCol);
mapStatusBallooned(1,:) = 1;
mapStatusBallooned(:,1) = 1;
mapStatusBallooned(600,:) = 1;
mapStatusBallooned(:,600) = 1;
mapStatusBallooned(390:490, 90:210) = 1;
mapStatusBallooned(440:550, 340:460) = 1;
mapStatusBallooned(190:310,190:310) = 1;
mapStatusBallooned(40:160, 40:160) = 1;
mapStatusBallooned(90:330, 490:610) = 1;
mapBallooned = map2d(sizeRow,sizeCol);
mapBallooned.cellStatus = mapStatusBallooned;
% show origin image
img = map.showMapMatrixImg();
imshow(img);
% show ballooned image
figure;
imgBallooned = mapBallooned.showMapMatrixImg();
imshow(imgBallooned);
%% generate astar origin map
% % build path
% startPoint = [25,25];
% endPoint = [550,550];
% scoreFlag = 'diagonal'; %'manhattan';
% logFileName = 'realexpMap1-astar.csv';
% gridSize = 1;
% figure;
% [path_mat, imgResult] = astarNew(map,startPoint, endPoint, scoreFlag, logFileName, gridSize);
% x = path_mat(:,1);
% y = path_mat(:,2);
% hold on;
% plot(y, x);
%%  generate astar ballooned map:
% startPoint = [25,25];
% endPoint = [550,550];
% scoreFlag = 'diagonal';
% logFileName = 'realexpMap1Ballooned-astar.csv';
% gridSize = 1;
% figure;
% [path_mat, imgResult] = astarNew(mapBallooned,startPoint, endPoint, scoreFlag, logFileName, gridSize);
% x = path_mat(:,1);
% y = path_mat(:,2);
% hold on;
% plot(y, x);
%%
logFileName = 'realexpMap1Ballooned-astar.csv';
path = csvPathSelectGuan(logFileName);
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

vmax = 150;
amax = 100;
maxIter = 10000;
[r,A,B,time,initState] = mainConstraint(newCons, newPath, amax, vmax, 20, true, 2, maxIter);
disp(r);
dt = 0.01;
mat = plotSmoothPath(time, r, dt, false);
disp(mat);
 
% format long g; % no scientific notation
fid = fopen('realExpriment1-smooth.csv', 'w');
legend = {'x', 'y' ,'vx', 'vy', 'time'};
fprintf(fid, '%s,%s,%s,%s,%s\n', legend{:});
for i = 1: length(mat)
    [row,col] = size(mat{i});
    for j = 1: row
        fprintf(fid, '%3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', mat{i}(j,:));
    end
end
fclose(fid);