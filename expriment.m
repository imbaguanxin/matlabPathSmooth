% build map
% build map
sizeRow = 600;
sizeCol = 600;
mapStatus = zeros(sizeRow, sizeCol);
mapStatus(1,:) = 1;
mapStatus(:,1) = 1;
mapStatus(600,:) = 1;
mapStatus(:,600) = 1;
mapStatus(400:500, 100:200) = 1;
mapStatus(450:550, 350:450) = 1;
mapStatus(200:300, 200:300) = 1;
mapStatus(50:150, 50:150) = 1;
mapStatus(100:320, 500:600) = 1;
map = map2d(sizeRow,sizeCol);
map.cellStatus = mapStatus;

% build path
% path = {[25,25],[250,50],[400,300],[400,500],[550,550]};
path = {[25,25],[200,50],[150, 300],[350,400],[450,550],[550,575]};
% set radius
radius = 50;
% 
% set output picture size
picSize = 800;
% 
% set visualization mode
% possible modes: 'ellipse-only', 'line-only', 'all'
% input other command will result in a map with safe areas without ellipse
% and lines.
visMode = 'ellipse-only';
% % visMode = 'line-only';
% run the function, all constrain is stored
constraints = ellipseGenerateWrap(map,path,picSize,radius,visMode);

constraints = constraintsSelector(constraints);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% auto part

newCons = constraints(1:4);
newPath = path(1:5);
newPath = transCorList(newPath,map);

vmax = 13;
amax = 3;
[r,A,B,time,initState] = mainConstraint(newCons, newPath, amax, vmax, 5, false, 5);
disp(r);
dt = 0.1;
mat = plotSmoothPath(time, r, dt);
disp(mat);
 
% format long g; % no scientific notation
fid = fopen('result.csv', 'w');
legend = {'time', 'x', 'y' ,'vx', 'vy'};
fprintf(fid, '%s,%s,%s,%s,%s\n', legend{:});
for i = 1: length(mat)
    [row,col] = size(mat{i});
    for j = 1: row
        fprintf(fid, '%3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', mat{i}(j,:));
    end
end

