%%
clc;
clear all;
close all;
%%
% build map
sizeRow = 600;
sizeCol = 600;
mapStatus = zeros(sizeRow, sizeCol);
mapStatus(1,:) = 1;
mapStatus(:,1) = 1;
mapStatus(600,:) = 1;
mapStatus(:,600) = 1;
% map 3
mapStatus(1:100, 250:350) = 1;
mapStatus(101:200, 150:450) = 1;
mapStatus(201:350, 150:250) = 1;
mapStatus(251:400, 350:450) = 1;
mapStatus(401:500, 150:450) = 1;
mapStatus(501:600, 250:350) = 1;
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
mapStatusBallooned(1:110, 240:360) = 1;
mapStatusBallooned(91:210, 140:460) = 1;
mapStatusBallooned(191:360, 140:260) = 1;
mapStatusBallooned(241:410, 340:460) = 1;
mapStatusBallooned(391:510, 140:460) = 1;
mapStatusBallooned(491:600, 240:360) = 1;
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
% logFileName = 'realexpMap3-astar.csv';
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
% logFileName = 'realexpMap3Ballooned-astar.csv';
% gridSize = 1;
% figure;
% [path_mat, imgResult] = astarNew(mapBallooned,startPoint, endPoint, scoreFlag, logFileName, gridSize);
% x = path_mat(:,1);
% y = path_mat(:,2);
% hold on;
% plot(y, x);
%% find selected path for path smooth
logFileName = 'realexpMap3Ballooned-astar.csv';
path = csvPathSelectGuan(logFileName);
% path{15} = [461, 461];
% path(14) = [];
% path(13) = [];
% path{12} = [240, 461];
% path(11) = [];
% path{9} = [280, 300];
% path{8} = [321, 300];
% path(7) = [];
% path(6) = [];
% path{5} = [361, 260];
% path(4) = [];
% path{3} = [361, 139];
x = [];
y = [];
for i = 1 : length(path)
    x = [x; path{i}(1)];
    y = [y; path{i}(2)];
end
hold on;

plot(y, x);

% set radius
radius = 30;

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
amax = 20;
maxIter = 10000;
[r,A,B,time,initState] = mainConstraint(newCons, newPath, amax, vmax, 10, true, 2, maxIter);
disp(r);
dt = 0.03;
mat = plotSmoothPath(time, r, dt, false);
disp(mat);
 
% format long g; % no scientific notation
fid = fopen('realExpriment3-smooth.csv', 'w');
legend = {'time', 'x', 'y' ,'vx', 'vy'};
fprintf(fid, '%s,%s,%s,%s,%s\n', legend{:});
for i = 1: length(mat)
    [row,col] = size(mat{i});
    for j = 1: row
        fprintf(fid, '%3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', mat{i}(j,:));
    end
end