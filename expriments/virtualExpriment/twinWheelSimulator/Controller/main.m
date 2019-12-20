clear all;
close all;
clc;
%% 
% t = 0: 0.05 * pi: 2 * pi;
% target = [1.5 * cos(t)', 1.2 * sin(t)'];
%% 
t = 0: 0.2: 10;
target = [t', t' + 1];
%%
xt = target(:,1);
yt = target(:,2);
poseCurrent = [0, 0, pi * 0 / 10];
n = 10;
dtCar = 0.01;
dtPub = n * dtCar;
currentTargetIndex = 1;
targetCurrent = target(currentTargetIndex, :);
poseList = [poseCurrent];
promoteCount = 0;
for i = 0: n * (length(target) - 1)
    if (promoteCount == n)
        promoteCount = 0;
        currentTargetIndex = currentTargetIndex + 1;
        targetCurrent = target(currentTargetIndex, :);
    end
    [v, w] = zhangController(poseCurrent(1), poseCurrent(2), poseCurrent(3) ,targetCurrent(1) ,targetCurrent(2), 0.2, 1, 1, 2, 0.1, pi/2);
    poseCurrent = calcNextPose(poseCurrent, v, w, dtCar);
    promoteCount = 1 + promoteCount;
    poseList = [poseList; poseCurrent];
end
plot(xt, yt,'o');
hold on;
xp= poseList(:,1);
yp = poseList(:,2);
plot(xp, yp)
axis square
axis equal