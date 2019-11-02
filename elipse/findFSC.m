function [sin,cos] = findFSC(p1,p2,xbound)
%FINDSINCOS Summary of this function goes here
%  Detailed explanation goes here
point1 = [p1(2), xbound - p1(1)];
point2 = [p2(2), xbound - p2(1)];
pbigger = point1;
psmaller = point2;
if (point1(1) < point2(1))
    pbigger = point2;
    psmaller = point1;
end
distance = sqrt((point1(1) - point2(1))^2 + (point1(2) - point2(2))^2);
% fprintf("bigger");
% disp(pbigger);
% fprintf("smaller");
% disp(psmaller);
dx = pbigger(1) - psmaller(1);
dy = pbigger(2) - psmaller(2);
% fprintf("dx");
% disp(dx);
% fprintf("dy");
% disp(dy);
sin = - dy / distance;
cos = dx / distance;
end

