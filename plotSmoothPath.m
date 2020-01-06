function result = plotSmoothPath(timeList,vector, dt, whetherNewFig)
%PLOTPATH plot quadProg result
%   Given time list and quadProg result, visualize the path.
if (whetherNewFig)
    figure;
end
result = cell(1,length(timeList));
tadder = 0;
smallTime = 0;
for i = 1 : length(timeList)
    start = (i-1) * 10;
    t = smallTime:dt:timeList(i);
    rt = t + tadder;
    x = vector(start + 1) * t.^4 + vector(start + 2) * t.^3 ...
        + vector(start + 3) * t.^2 + vector(start + 4) * t.^1 ...
        + vector(start + 5);
    y = vector(start + 6) * t.^4 + vector(start + 7) * t.^3 ...
        + vector(start + 8) * t.^2 + vector(start + 9) * t.^1 ...
        + vector(start + 10);
    vx = 4 * vector(start + 1) * t.^3 + 3 * vector(start + 2) * t.^2 ...
        + 2 * vector(start + 3) * t + vector(start + 4);
    vy = 4 * vector(start + 6) * t.^3 + 3 * vector(start + 7) * t.^2 ...
        + 2 * vector(start + 8) * t + vector(start + 9);
    group = [x.', y.', vx.', vy.', rt.'];
    result{i} = group;
    plot(x,y);
    hold on;
    tadder = tadder + timeList(i);
    smallTime = dt - tadder + rt(length(rt)); 
end
end

