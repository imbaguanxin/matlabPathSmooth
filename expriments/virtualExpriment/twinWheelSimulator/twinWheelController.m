function [v, w] = twinWheelController(xc, yc, yawc, xt, yt, l, kv, kw)
dx = xt - xc;
dy = yt - yc;
linear = dx * cos(yawc) + dy * sin(yawc);
angularTemp = -dx * sin(yawc) + dy * cos(yawc);
angular = angularTemp / l * 2;
v = linear * kv;
w = angular * kw;
end

