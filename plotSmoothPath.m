function result = plotSmoothPath(timeList,vector)
%PLOTPATH plot quadProg result
%   Given time list and quadProg result, visualize the path.
figure;
for i = 1 : length(timeList)
    start = (i-1) * 10;
    t = 0:0.1:timeList(i);
    x = vector(start + 1) * t.^4 + vector(start + 2) * t.^3 ...
        + vector(start + 3) * t.^2 + vector(start + 4) * t.^1 ...
        + vector(start + 5);
    y = vector(start + 6) * t.^4 + vector(start + 7) * t.^3 ...
        + vector(start + 8) * t.^2 + vector(start + 9) * t.^1 ...
        + vector(start + 10);
    plot(x,y);
    hold on;
end
result = true;
end

