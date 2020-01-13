function [result,A,B,time,finalState] = mainConstraintTime(constraints,changedPath,amax,vmax,consNum, inputTime, maxIter)
%MAINCONSTRAINT Summary of this function goes here
%   Detailed explanation goes here
options = optimoptions('quadprog');
options = optimoptions(options,'MaxIterations', maxIter); 
numOfOrder = 5;
numOfTotalSeg = length(changedPath) - 1;
fprintf("segment number:");
disp(numOfTotalSeg);
time = inputTime;
if (length(constraints) == length(changedPath) - 1)
    % calculate time
    if (length(time) == length(constraints))
        % build constrain A and B
        A = [];
        B = [];
        for i = 1 : numOfTotalSeg
            cons = constraints{i};
            center = (changedPath{i} + changedPath{i+1})/2;
            [m,b] = splitConstrain(cons,center);
            Atemp = [];
            Btemp = [];
            for j = 0 : time(i)/consNum : time(i)
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
        fprintf("start quadprog");
        result = quadprog(H,f,A,B,aeq,beq,[],[],[],options);
        % cal the velocity and acceleration at the last point
        t = time(length(time));
        startIndex = length(result) - 10;
        vx = 4*result(startIndex+1)*t^3 + 3*result(startIndex+2)*t^2 + 2*result(startIndex+3)*t + result(startIndex+4);
        ax = 12*result(startIndex+1)*t^2 + 6*result(startIndex+2)*t + 2*result(startIndex+3);
        startIndex = length(result) - 5;
        vy = 4*result(startIndex+1)*t^3 + 3*result(startIndex+2)*t^2 + 2*result(startIndex+3)*t + result(startIndex+4);
        ay = 12*result(startIndex+1)*t^2 + 6*result(startIndex+2)*t + 2*result(startIndex+3);
        finalState = [vx, vy, ax, ay];
    else
        fprintf("length of constraints is different from length of time\n");
        fprintf("length of constraints: ");
        disp(length(constraints));
        fprintf("length of time: ");
        disp(length(time));
    end

else
    fprintf("constraints and path have different size (constraints + 1 = path)\n");
    fprintf("size of constraints:");
    disp(length(constraints));
    fprintf("size of path:");
    disp(length(changedPath));
    fprintf("total segment should be <= 4, input:");
    disp(numOfTotalSeg);
end




