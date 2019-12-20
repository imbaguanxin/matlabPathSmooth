function finalPose = calcNextPose(nowPose,vel,w,time)
%CALCNEXTPOINT Summary of this function goes here
%   Detailed explanation goes here
x = nowPose(1);
y = nowPose(2);
yaw = nowPose(3);
if (abs(w) <= 0.0001)
    finalPose = [x + vel * time * cos(yaw), y + vel * time * sin(yaw), yaw];
else
    R = abs(vel / w);
    unitvec = sign(w) * [-sin(yaw), cos(yaw)];
    ctr = [x, y] + unitvec * R;
    fyaw = yaw + w * time;
    temp = sign(w) * [sin(fyaw), -cos(fyaw)];
    temp = R * temp + ctr;
%     temp = [x,y] - ctr;
%     theta =  w * time;
%     temp = [cos(theta), -sin(theta); sin(theta), cos(theta)] * temp';
%     temp = temp' + ctr;
    finalPose = [temp(1), temp(2), fyaw];
end
end