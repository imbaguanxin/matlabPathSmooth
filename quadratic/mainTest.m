cons1 = [1,1,2;   1,1,-2;   -1,1,2;   -1,1,-2];
center1 = [0,0];
cons2 = [1,1,0;   1,1,-4;   -1,1,4;   -1,1,0];
center2 = [2,0];
cons3 = [1,1,-2;   1,1,-6;   -1,1,6;   -1,1,2];
center3 = [4,0];
cons4 = [1,1,-4;   1,1,-8;   -1,1,8;   -1,1,4];
center4 = [6,0];
cons5 = [1,1,-6;   1,1,-10;   -1,1,10;   -1,1,6];
center5 = [8,0];

constraints = {cons1, cons2, cons3, cons4, cons5};
path = {[-1,0.5],[1,0],[3,0.5],[5,-0.5], [7,0],[9,-0.5]};
amax = 4;
vmax = 15;

[r,A,B,time,initState] = mainConstraint(constraints, path, amax, vmax);

disp(r);
plotSmoothPath(time,r);
for i = 1 : length(path)
    pt = path{i};
    plot(pt(1),pt(2),'o');
    hold on;
end

