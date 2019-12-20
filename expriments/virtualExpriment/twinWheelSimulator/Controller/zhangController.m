function [v, w] = zhangController(xc, yc, yawc, xt, yt, l, kv, kw, vmax, vmin, wmax)
dx = xt - xc;
dy = yt - yc;
linear = dx * cos(yawc) + dy * sin(yawc);
angularTemp = -dx * sin(yawc) + dy * cos(yawc);
angular = angularTemp / l * 2;
v = linear * kv;
w = angular * kw;
if (abs(v) > vmax)
    v = vmax * sign(v);
end
if (abs(v) < vmin)
    v = vmin * sign(v);
end
if (abs(w) > wmax)
    w = wmax * sign(w);
end
end