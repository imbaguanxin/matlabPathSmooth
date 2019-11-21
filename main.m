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

% set radius
radius = 50;

% set output picture size
picSize = 900;

% set visualization mode
% possible modes: 'ellipse-only', 'line-only', 'all'
% input other command will result in a map with safe areas without ellipse
% and lines.
% visMode = 'ellipse-only';
visMode = 'none';
% run the function, all constrain is stored
constraints = ellipseGenerateWrap(map,path,picSize,radius,visMode);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% auto part
% constraints = constraints(1:4);
% path = path(1:5);

vmax = 15;
amax = 4;
[r,A,B] = mainConstraint(constraints, path, map, amax, vmax);
disp(r);
plotSmoothPath(time, r);

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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find constrain finished
% path = path(1:5);
% constraints = constraints(1:4);
% changedPath = cell(length(path),1);
% for i = 1 : length(path)
%     pt = map.pointToXYCor(path{i});
%     changedPath{i} = pt;
%     disp(changedPath{i});
% end
% 
% % % % 
% cons1 = constraints{1};
% center1 = (changedPath{1} + changedPath{2})/2;
% cons2 = constraints{2};
% center2 = (changedPath{2} + changedPath{3})/2;
% cons3 = constraints{3};
% center3 = (changedPath{3} + changedPath{4})/2;
% cons4 = constraints{4};
% center4 = (changedPath{4} + changedPath{5})/2;
% % % % 
% [m1,b1] = splitConstrain(cons1,center1);
% [m2,b2] = splitConstrain(cons2,center2);
% [m3,b3] = splitConstrain(cons3,center3);
% [m4,b4] = splitConstrain(cons4,center4);
% % % % % 
% time = zeros(1,length(changedPath) - 1);
% vmax = 15;
% amax = 4;
% for i = 1:length(time)
%     time(i) = findTime(changedPath{i},changedPath{i+1},amax,vmax);
% end
% % % % 
% % time = [15,15,15,15];
% % % % % t1 = 15;
% % % % % t2 = 15;
% % % % % t3 = 15;
% % % % % t4 = 30;
% % % % % t5 = 25;
% A1 = [];
% A2 = [];
% A3 = [];
% A4 = [];
% % % % % A5 = [];
% B1 = [];
% B2 = [];
% B3 = [];
% B4 = [];
% % % % % B5 = [];
% % % % 
% % % % % build constraints
% for i = 0 : 5 : floor(time(1))
%     A1 = [A1; constrain2A(m1,5,i,1,4)];
%     B1 = [B1; b1];
% end
% for i = 0 : 5 : floor(time(2))
%     A2 = [A2; constrain2A(m2,5,i,2,4)];
%     B2 = [B2; b2];
% end
% for i = 0 : 5 : floor(time(3))
%     A3 = [A3; constrain2A(m3,5,i,3,4)];
%     B3 = [B3; b3];
% end
% for i = 0 : 5 : floor(time(4))
%     A4 = [A4; constrain2A(m4,5,i,4,4)];
%     B4 = [B4; b4];
% end
% % % % % for i = 0 : 0.1 : floor(t5)
% % % % %     A5 = [A5; constrain2A(m5,5,i,5,5)];
% % % % %     B5 = [B5; b5];
% % % % % end
% % % % 
% Afinal = [A1 ; A2; A3; A4];
% Bfinal = [B1 ; B2; B3; B4];  
% % % % 
% beq = genBeq(changedPath);
% f = zeros(1, length(time) * 10);
% H = genHessenberg(time);
% aeq = genAeq(time);
% z = quadprog(H,f,Afinal,Bfinal,aeq,beq);
% plotSmoothPath(time, z);

% 
% 
% 
