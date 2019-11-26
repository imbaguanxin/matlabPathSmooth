cons1 = [1,1,2;   1,1,-2;   -1,1,2;   -1,1,-2];
cons2 = [1,1,0;   1,1,-4;   -1,1,4;   -1,1,0];
cons3 = [1,1,-2;   1,1,-6;   -1,1,6;   -1,1,2];
cons4 = [1,1,-4;   1,1,-8;   -1,1,8;   -1,1,4];
cons5 = [1,1,-6;   1,1,-10;   -1,1,10;   -1,1,6];
cons6 = [1,1,-8;   1,1,-12;   -1,1,12;   -1,1,8];
cons7 = [1,1,-10;   1,1,-14;   -1,1,14;   -1,1,10];

constraints = {cons1, cons2, cons3, cons4, cons5, cons6, cons7};
path = {[-1,0.5],[1,0],[3,0.5],[5,-0.5], [7,0],[9,-0.5],[11,0.6], [12.5,1]};
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

