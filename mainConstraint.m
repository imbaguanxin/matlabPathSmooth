function [result,A,B,time] = mainConstraint(constraints,path,map,amax,vmax)
%MAINCONSTRAINT Summary of this function goes here
%   Detailed explanation goes here
options = optimoptions('quadprog');
options = optimoptions(options,'MaxIterations', 5e+4); 
numOfOrder = 5;
numOfTotalSeg = length(path) - 1;
fprintf("segment number:");
disp(numOfTotalSeg);
if (length(constraints) == length(path) - 1)
    % transform corrdinates
    changedPath = cell(length(path),1);
    for i = 1 : length(path)
        pt = map.pointToXYCor(path{i});
        changedPath{i} = pt;
    end
    % calculate time
    time = zeros(1,numOfTotalSeg);
    for i = 1:length(time)
        time(i) = 10;%findTime(changedPath{i},changedPath{i+1},amax,vmax);
    end
    % build constrain A and B
    A = [];
    B = [];
    for i = 1 : numOfTotalSeg
        cons = constraints{i};
        center = (changedPath{i} + changedPath{i+1})/2;
        [m,b] = splitConstrain(cons,center);
        Atemp = [];
        Btemp = [];
        for j = 0 : floor(floor(time(i))/3) : floor(time(i))%floor(floor(time(i))/3)
            Atemp = [Atemp; constrain2A(m,numOfOrder,j,i,numOfTotalSeg)];
            Btemp = [Btemp; b];
        end
%         fprintf("size Atemp");
%         disp(size(Atemp));
%         fprintf("size Btemp");
%         disp(size(Btemp));
        A = [A; Atemp];
        B = [B; Btemp];
%         fprintf("size A");
%         disp(size(A));
%         fprintf("size B");
%         disp(size(B));
    end
    
    beq = genBeq(changedPath);
    f = zeros(1, length(time) * 10);
    H = genHessenberg(time);
    aeq = genAeq(time);
    
    result = quadprog(H,f,A,B,aeq,beq,[],[],[],options);
else
    fprintf("constraints and path have different size (constraints + 1 = path)\n");
    fprintf("size of constraints:");
    disp(length(constraints));
    fprintf("size of path:");
    disp(length(path));
end




