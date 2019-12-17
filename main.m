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
% path = {[11,19],[90,120],[400,120],[750,120],[750,350],[600,340]};
path = {[11,19],[90,120],[80,400],[80,570],[450,570],[450,350],[750,350],[750,100]};
% set radius
radius = 50;

% set output picture size
picSize = 900;

% set visualization mode
% possible modes: 'ellipse-only', 'line-only', 'all'
% input other command will result in a map with safe areas without ellipse
% and lines.
% visMode = 'ellipse-only';
% visMode = 'line-only';
visMode = '';
% run the function, all constrain is stored
constraints = ellipseGenerateWrap(map,path,picSize,radius,visMode);

constraints = constraintsSelector(constraints);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% auto part

newCons = constraints;
newPath = path;
newPath = transCorList(newPath,map);

vmax = 13;
amax = 3;
maxIter = 10000;
[r,A,B,time,initState] = mainConstraint(newCons, newPath, amax, vmax, 10, false, 10, maxIter);
disp(r);
dt = 0.1;
mat = plotSmoothPath(time, r, dt, false);
disp(mat);

% format long g; % no scientific notation
fid = fopen('main_result.csv', 'w');
legend = {'time', 'x', 'y' ,'vx', 'vy'};
fprintf(fid, '%s,%s,%s,%s,%s\n', legend{:});
for i = 1: length(mat)
    [row,col] = size(mat{i});
    for j = 1: row
        fprintf(fid, '%3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', mat{i}(j,:));
    end
end

%===========================================
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